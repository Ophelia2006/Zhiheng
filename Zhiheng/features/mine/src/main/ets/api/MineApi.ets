import { User } from '@ohos/auth/src/main/ets/model/User';
import { Resume, ResumeParseStatus, Education, Experience, Project } from '@ohos/model/src/main/ets/Resume';
import { HttpUtil, HttpResponse } from '@ohos/network'
import { hilog } from '@kit.PerformanceAnalysisKit';
import { ResumeCardModel } from '@ohos/model/src/main/ets/Resume'

/**
 * Mine 模块 API 层
 * 负责处理用户资料、账号安全、简历的增删改查网络请求。
 * 目前没有后端接口，使用 setTimeout 异步模拟 HTTP 请求。
 */
export class MineApi {
  // /**
  //  * 获取当前登录用户的基本信息
  //  * @TODO 真实场景应替换为 HttpUtil.get('/api/v1/user/profile')
  //  */
  // static async getUserProfile(): Promise<User> {
  //   return new Promise((resolve) => {
  //     setTimeout(() => {
  //       // 模拟返回当前登录用户数据
  //       resolve({
  //         id: 'user_123',
  //         username: 'Sheldon Craig',
  //         avatarUrl: '', // 预留头像 URL 字段
  //         token: 'mock_token_abc123'
  //       } as User);
  //     }, 500); // 模拟 500ms 网络延迟
  //   });
  // }



  /**
   * 修改账号密码
   * @param oldPwd 旧密码
   * @param newPwd 新密码
   * @TODO 真实场景应替换为 HttpUtil.post('/api/v1/user/password', { oldPassword: oldPwd, newPassword: newPwd })
   */
  static async changePassword(oldPwd: string, newPwd: string): Promise<boolean> {
    return new Promise((resolve) => {
      setTimeout(() => {
        // 模拟修改成功
        // 实际场景中，如果旧密码错误，后端会返回非200状态码，这里应该 reject 抛出异常
        console.info(`Mock API: Password changed from ${oldPwd} to ${newPwd}`);
        resolve(true);
      }, 800); // 模拟 800ms 处理延迟
    });
  }
}