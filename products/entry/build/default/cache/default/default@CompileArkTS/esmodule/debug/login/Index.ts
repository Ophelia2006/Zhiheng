import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { MainPage } from "@bundle:com.example.zhiheng/entry@login/ets/components/MainPage";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.LOGIN_LOGIN:
            import("@bundle:com.example.zhiheng/entry@login/ets/pages/LoginPage");
            break;
        case BuilderNameConstants.LOGIN_REGISTER:
            import("@bundle:com.example.zhiheng/entry@login/ets/pages/RegisterPage");
            break;
        default:
            break;
    }
}
