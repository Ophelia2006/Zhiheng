import { AbilityConstant, UIAbility, Want, common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AuthService } from '@ohos/auth'
import { User } from '@ohos/auth'
import { HttpUtil } from '@ohos/network';

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    const context = this.context
    // 1. 先从本地首选项恢复基础登录状态和缓存的用户信息
    await AuthService.initAuthStatus(context)

    // 2. 如果已经有本地 Token（处于登录状态），则去后端异步获取最新用户信息
    if (AuthService.checkLogin()) {
      this.fetchLatestUserInfo(context);
    }
  }

  private async fetchLatestUserInfo(context: common.UIAbilityContext) {

    try {
      hilog.debug(0, 'fetchLatestUserInfo', `获取用户信息1`)

      // 后端昵称数据
      const userInfoUrl = 'http://172.20.10.2:10020/api/user/service/info';
      const userInfoRes = await HttpUtil.get<Record<string, Object>>(userInfoUrl);
      hilog.debug(0, 'fetchLatestUserInfo', `获取的用户信息 ${JSON.stringify(userInfoRes)}`)

      if (userInfoRes) {
        // 构造要更新的部分用户信息，显式声明为 Partial<User>
        const updatedUser: Partial<User> = {
          id: userInfoRes.accountId ? (userInfoRes.accountId as string) : undefined,
          username: userInfoRes.nickName ? (userInfoRes.nickName as string) : undefined,
          avatarUrl: userInfoRes.avatar ? (userInfoRes.avatar as string) : undefined,
        };

        // 调用 AuthService 暴露的更新方法，它会自动更新内存、AppStorage 和首选项
        await AuthService.updateUserInfo(context, updatedUser);
        hilog.info(0x0000, 'EntryAbility', '成功从后端获取并更新最新用户信息');
      }
    } catch (err) {
      hilog.error(0x0000, 'EntryAbility', `从后端获取最新用户信息失败: ${JSON.stringify(err)}`);
    }
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
