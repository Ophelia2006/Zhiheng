// commons/RouterModule/src/main/ets/utils/AuthService.ets
import { User } from '../model/User';
import { hilog } from '@kit.PerformanceAnalysisKit';
import preferences from '@ohos.data.preferences';
import { common } from '@kit.AbilityKit';

export class AuthService {
  private static isLogin: boolean = false;
  private static currentUser: User | null = null;
  private static readonly PREF_NAME = 'auth_preferences';
  private static readonly TOKEN_KEY = 'jwt_token';
  private static readonly USER_ID_KEY = 'user_id';
  private static readonly USER_NAME_KEY = 'user_name';

  /**
   * 初始化应用时，从首选项中恢复登录状态
   * 可以在 EntryAbility 的 onCreate 中调用此方法
   */
  public static async initAuthStatus(context: common.UIAbilityContext) {
    try {
      const pref = await preferences.getPreferences(context, AuthService.PREF_NAME);
      const savedToken = await pref.get(AuthService.TOKEN_KEY, '') as string;
      const savedUserId = await pref.get(AuthService.USER_ID_KEY, 'user_from_cache') as string;
      const savedUserName = await pref.get(AuthService.USER_NAME_KEY, 'CachedUser') as string;
      
      if (savedToken) {
        AuthService.isLogin = true;
        AuthService.currentUser = {
          id: savedUserId,
          username: savedUserName,
          avatarUrl: '',
          token: savedToken
        };
        hilog.debug(0,'AuthService',`AuthService.currentUser 储存的数据 ${JSON.stringify(AuthService.currentUser)}`)

        AppStorage.setOrCreate('currentUser', AuthService.currentUser);
      }
    } catch (err) {
      hilog.error(0x0000, 'AuthService', `Failed to restore token: ${err}`);
    }
  }

  /**
   * 更新用户信息 (供外部网络请求成功后调用)
   */
  public static async updateUserInfo(context: common.UIAbilityContext, user: Partial<User>) {
    if (AuthService.currentUser) {
      // 使用逻辑或 (||) 操作符：如果传入的 user 属性有值就用传入的，否则保持原来的值
      AuthService.currentUser = {
        id: user.id || AuthService.currentUser.id,
        username: user.username || AuthService.currentUser.username,
        avatarUrl: user.avatarUrl || AuthService.currentUser.avatarUrl,
        token: user.token || AuthService.currentUser.token,
      }
      AppStorage.setOrCreate('currentUser', AuthService.currentUser);
      
      try {
        const pref = await preferences.getPreferences(context, AuthService.PREF_NAME);
        await pref.put(AuthService.USER_ID_KEY, AuthService.currentUser.id);
        await pref.put(AuthService.USER_NAME_KEY, AuthService.currentUser.username);
        await pref.flush();
        hilog.info(0x0000, 'AuthService', `User info updated and persisted.`);
      } catch (err) {
        hilog.error(0x0000, 'AuthService', `Failed to persist updated user info: ${err}`);
      }
    }
  }

  public static async login(context: common.UIAbilityContext, token?: string, user?: User) {
    AuthService.isLogin = true;
    
    if (!token) {
      hilog.error(0x0000, 'AuthService', `Login without JWT Token! (Mock token removed)`);
    }
    
    AuthService.currentUser = user || {
      id: 'default_user',
      username: 'User',
      avatarUrl: '',
      token: token || ''
    };
    
    if (token) {
      AuthService.currentUser.token = token;
      AppStorage.setOrCreate('currentUser', AuthService.currentUser);
      hilog.info(0x0000, 'AuthService', `Login Success! JWT Token saved to memory: ${AuthService.currentUser.token}`);
      
      // 保存 Token 到首选项持久化存储
      try {
        const pref = await preferences.getPreferences(context, AuthService.PREF_NAME);
        await pref.put(AuthService.TOKEN_KEY, token);
        await pref.put(AuthService.USER_ID_KEY, AuthService.currentUser.id);
        await pref.put(AuthService.USER_NAME_KEY, AuthService.currentUser.username);
        await pref.flush();
        hilog.info(0x0000, 'AuthService', `JWT Token and user info persisted to preferences successfully.`);
      } catch (err) {
        hilog.error(0x0000, 'AuthService', `Failed to persist token to preferences: ${err}`);
      }
    }
  }

  public static async logout(context: common.UIAbilityContext) {
    AuthService.isLogin = false;
    AuthService.currentUser = null;
    AppStorage.setOrCreate('currentUser', null);
    
    try {
      const pref = await preferences.getPreferences(context, AuthService.PREF_NAME);
      await pref.delete(AuthService.TOKEN_KEY);
      await pref.delete(AuthService.USER_ID_KEY);
      await pref.delete(AuthService.USER_NAME_KEY);
      await pref.flush();
      hilog.info(0x0000, 'AuthService', `JWT Token removed from preferences.`);
    } catch (err) {
      hilog.error(0x0000, 'AuthService', `Failed to remove token from preferences: ${err}`);
    }
  }

  public static checkLogin(): boolean {
    return AuthService.isLogin;
  }

  public static getUser(): User | null {
    return AuthService.currentUser;
  }
}