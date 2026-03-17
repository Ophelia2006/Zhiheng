// commons/RouterModule/src/main/ets/utils/AuthService.ets

export class AuthService {
  private static isLogin: boolean = false;

  public static login() {
    AuthService.isLogin = true;
    // 保存 Token 到 Preferences
  }

  public static logout() {
    AuthService.isLogin = false;
    // 清除 Token
  }

  public static checkLogin(): boolean {
    return AuthService.isLogin;
  }
}