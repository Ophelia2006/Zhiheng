import { Resume, ResumeCardModel, ResumeParseStatus, Education, Experience, Project } from '@ohos/model/src/main/ets/Resume';
import { HttpUtil, HttpResponse } from '../utils/HttpUtil';
import { hilog } from '@kit.PerformanceAnalysisKit';

export class ResumeApi {

  /**
   * 获取当前用户的全部简历列表
   */
  static async getResumeList(): Promise<ResumeCardModel[]> {
    try {
      const url = ':10020/api/interviewee/form/search/name/list';

      // 发起 GET 请求
      const response = await HttpUtil.get<HttpResponse<Record<string, Object>[]>>(url);
      hilog.debug(0, 'ResumeApi', `面试报告列表原始响应: ${JSON.stringify(response)}`)

      const listData = response.data;
      const resumeList: ResumeCardModel[] = [];

      if (listData && listData.length > 0) {
        for (let i = 0; i < listData.length; i++) {
          const item = listData[i];

          let dateStr = '未知日期';
          if (item.createTime) {
            const date = new Date(String(item.createTime));
            if (!isNaN(date.getTime())) {
              const month = date.getMonth() + 1; // getMonth() 返回 0-11
              const day = date.getDate();
              dateStr = `${month}月${day}日`;
            }
          }

          const resumeItem: ResumeCardModel = {
            id: item.id ? String(item.id) : '',
            title: item.formName ? String(item.formName) : '未命名面试',
            date: dateStr
          };
          resumeList.push(resumeItem);
        }
      }

      return resumeList;
    } catch (err) {
      const error: Error = err
      hilog.error(0, 'ResumeApi', `获取简历列表失败, 错误详情: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 删除简历
   * @param resumeId 简历唯一标识
   */
  static async deleteResume(resumeId: string): Promise<boolean> {
    try {
      // TODO: 请将此 URL 替换为实际的后端删除简历接口地址
      const url = ':10020/api/interviewee/form/delete';
      const reqParam: Record<string, string> = { "id": resumeId };

      hilog.debug(0, 'ResumeApi', `删除简历参数: ${JSON.stringify(reqParam)}`);

      const response = await HttpUtil.delete<HttpResponse<Object>>(url, reqParam);
      hilog.debug(0, 'ResumeApi', `删除简历响应: ${JSON.stringify(response)}`);
      
      return response.success === true || response.code === '0' ;
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'ResumeApi', `删除简历失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 获取单份简历的详细信息
   * @param resumeId 简历唯一标识
   */
  static async getResumeDetail(resumeId: string): Promise<Resume> {
    try {
      const url = ':10020/api/interviewee/form/search/by/id';
      hilog.debug(0, 'ResumeApi', `resumeId :${resumeId}`)

      const reqParam: Record<string, string> = {
        "id": resumeId
      };

      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, reqParam);
      const data = response.data;

      if (!data) {
        throw new Error('未获取到报告数据');
      }

      // 1. 解析教育经历
      const educationList: Education[] = [];
      const eduArr = data['educationExperiences'] as Record<string, Object>[];
      if (Array.isArray(eduArr)) {
        for (let i = 0; i < eduArr.length; i++) {
          const edu = eduArr[i];
          const degreeStr = String(edu['degree'] || '');
          
          educationList.push({
            id: `edu_${i}`,
            schoolName: String(edu['schoolName'] || ''),
            major: String(edu['major'] || ''),
            degree: degreeStr,
            startTime: String(edu['startDate'] || ''),
            endTime: String(edu['endDate'] || ''),
            isEduBackgroundInfo: String(edu['highlights'] || '')
          });
        }
      }

      // 2. 解析工作经历
      const experienceList: Experience[] = [];
      const expArr = data['workExperiences'] as Record<string, Object>[];
      if (Array.isArray(expArr)) {
        for (let i = 0; i < expArr.length; i++) {
          const exp = expArr[i];
          experienceList.push({
            id: `exp_${i}`,
            companyName: String(exp['companyName'] || ''),
            role: String(exp['position'] || ''),
            department: String(exp['department'] || ''),
            startTime: String(exp['startDate'] || ''),
            endTime: String(exp['endDate'] || ''),
            description: String(exp['workContent'] || '')
          });
        }
      }

      // 3. 解析项目经历
      const projectList: Project[] = [];
      const projArr = data['projectExperiences'] as Record<string, Object>[];
      if (Array.isArray(projArr)) {
        for (let i = 0; i < projArr.length; i++) {
          const proj = projArr[i];
          projectList.push({
            id: `proj_${i}`,
            projectName: String(proj['projectName'] || ''),
            role: String(proj['projectRole'] || ''),
            description: String(proj['projectDescription'] || ''),
            responsibilities: String(proj['responsibility'] || ''),
            achievements: String(proj['achievement'] || '')
          });
        }
      }
      
      // 4. 解析技能
      let skills: string[] = [];
      const skillsArr = data['professionalSkills'];
      if (Array.isArray(skillsArr)) {
        for (let i = 0; i < skillsArr.length; i++) {
           skills.push(String(skillsArr[i]));
        }
      }

      // 5. 严格映射数据到 Resume 接口
      const resumeDetail: Resume = {
        id: data['id'] ? String(data['id']) : resumeId,
        userId: data['userId'] ? String(data['userId']) : '',
        title: data['formName'] ? String(data['formName']) : '未命名简历',
        targetRole: data['jobIntention'] ? String(data['jobIntention']) : '未知意向岗位',
        parseStatus: ResumeParseStatus.COMPLETED,
        createTime: data['createTime'] ? new Date(String(data['createTime'])).getTime() : Date.now(),
        updateTime: Date.now(),
        
        personalInfo: {
          name: data['candidateName'] ? String(data['candidateName']) : '未知姓名',
          phone: '', 
          email: ''  
        },
        
        educationList: educationList,
        experienceList: experienceList,
        projectList: projectList,
        skills: skills
      };

      return resumeDetail;
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'ResumeApi', `获取简历详情失败 ${error}`);
      throw error;
    }
  }
}