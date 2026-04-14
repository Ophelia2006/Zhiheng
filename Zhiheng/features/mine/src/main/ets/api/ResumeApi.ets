import { HttpUtil, HttpResponse } from '@ohos/network'
import { hilog } from '@kit.PerformanceAnalysisKit';

export class ResumeApi {

  /**
   * 创建简历
   * @param resumeRecord 符合后端接口要求的数据结构
   * @returns 创建成功后的数据或状态
   */
  static async addResume(resumeRecord: Record<string, Object>): Promise<Record<string, Object>> {
    try {
      // TODO: 替换为实际的创建简历接口地址
      const url = ':10020/api/interviewee/form/add';
      
      hilog.debug(0, 'MineResumeApi', `开始发送创建简历请求，参数: ${JSON.stringify(resumeRecord)}`);
      
      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, resumeRecord);
      
      hilog.debug(0, 'MineResumeApi', `创建简历响应: ${JSON.stringify(response)}`);
      
      return response.data || {};
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'MineResumeApi', `创建简历失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 更新简历 (PUT 请求)
   * @param resumeRecord 包含 id 且符合后端接口要求的数据结构
   * @returns 更新成功后的数据或状态
   */
  static async updateResume(resumeRecord: Record<string, Object>): Promise<Record<string, Object>> {
    try {
      // TODO: 根据实际的后端接口路径进行替换
      const url = ':10020/api/interviewee/form/update';
      
      hilog.debug(0, 'MineResumeApi', `开始发送更新简历请求，参数: ${JSON.stringify(resumeRecord)}`);
      
      const response = await HttpUtil.put<HttpResponse<Record<string, Object>>>(url, resumeRecord);
      
      hilog.debug(0, 'MineResumeApi', `更新简历响应: ${JSON.stringify(response)}`);
      
      return response.data || {};
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'MineResumeApi', `更新简历失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }
}