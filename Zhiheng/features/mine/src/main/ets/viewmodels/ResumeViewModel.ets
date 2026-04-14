import { Resume, ResumeParseStatus } from '@ohos/model/src/main/ets/Resume';
import { ResumeApi } from '../api/ResumeApi';
import { ResumeApi as CommonResumeApi } from '@ohos/network';
import { hilog } from '@kit.PerformanceAnalysisKit';

export class ResumeViewModel {
  /**
   * 加载简历详情
   * @param resumeId 简历 ID
   */
  async loadResumeDetail(resumeId: string): Promise<Resume> {
    if (!resumeId) {
      throw new Error('简历 ID 不能为空');
    }

    try {
      hilog.info(0x0000, 'ResumeViewModel', `Start loading resume detail for: ${resumeId}`);
      const resumeDetail = await CommonResumeApi.getResumeDetail(resumeId);
      hilog.info(0x0000, 'ResumeViewModel', `Successfully loaded resume detail for: ${resumeId}`);
      hilog.debug(0, 'ResumeViewModel', `${JSON.stringify(resumeDetail)}`)
      return resumeDetail;
    } catch (err) {
      const error = err as Error
      hilog.error(0x0000, 'ResumeViewModel', `Failed to load resume detail: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 保存/更新简历信息
   * @param updatedResume 更新后的简历对象
   */
  async saveResume(updatedResume: Resume): Promise<boolean> {
    try {
      hilog.info(0x0000, 'ResumeViewModel', `Start saving resume: ${updatedResume.id}`);

      // 组装教育经历
      const educationExperiences: Record<string, string>[] = [];
      if (updatedResume.educationList) {
        for (let edu of updatedResume.educationList) {
          educationExperiences.push({
            'schoolName': edu.schoolName,
            'startDate': edu.startTime,
            'endDate': edu.endTime,
            'major': edu.major,
            'degree': edu.degree,
            'highlights': edu.isEduBackgroundInfo || ''
          });
        }
      }

      // 组装工作经历
      const workExperiences: Record<string, string>[] = [];
      if (updatedResume.experienceList) {
        for (let exp of updatedResume.experienceList) {
          workExperiences.push({
            'companyName': exp.companyName,
            'startDate': exp.startTime,
            'endDate': exp.endTime,
            'department': exp.department || '',
            'position': exp.role,
            'workContent': exp.description
          });
        }
      }

      // 组装项目经历
      const projectExperiences: Record<string, string>[] = [];
      if (updatedResume.projectList) {
        for (let proj of updatedResume.projectList) {
          projectExperiences.push({
            'projectName': proj.projectName,
            'projectRole': proj.role,
            'projectDescription': proj.description,
            'responsibility': proj.responsibilities,
            'achievement': proj.achievements || ''
          });
        }
      }

      // 构建传给后端的 JSON 对象
      const updateParam: Record<string, Object> = {
        "id": String(updatedResume.id), // 后端期望 string 类型的 id
        "formName": updatedResume.title || '未命名简历',
        "candidateName": updatedResume.personalInfo?.name || '',
        "jobIntention": updatedResume.targetRole || '',
        "professionalSkills": updatedResume.skills || [],
        "educationExperiences": educationExperiences,
        "workExperiences": workExperiences,
        "projectExperiences": projectExperiences
      };

      // 调用接口
      await ResumeApi.updateResume(updateParam);
      hilog.debug(0, 'ResumeViewModel', `简历修改参数 ${JSON.stringify(updateParam)}`)

      hilog.info(0x0000, 'ResumeViewModel', `Successfully saved resume: ${updatedResume.id}`);
      return true;
    } catch (error) {
      hilog.error(0x0000, 'ResumeViewModel', `Failed to save resume: ${(error as Error).message}`);
      return false;
    }
  }

  /**
   * 获取空简历模板，用于新建简历或占位
   */
  getEmptyResume(): Resume {
    return {
      id: '',
      userId: '',
      title: '',
      targetRole: '',
      personalInfo: {
        name: '',
        phone: '',
        email: ''
      },
      educationList: [],
      experienceList: [],
      projectList: [],
      skills: [],
      parseStatus: ResumeParseStatus.UNPARSED,
      createTime: Date.now(),
      updateTime: Date.now()
    };
  }
}