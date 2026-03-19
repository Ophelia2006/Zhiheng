import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { PersonalPage } from "@bundle:com.example.zhiheng/entry@mine/ets/pages/PersonalPage";
export { ProfileComponent as ProfilePage } from "@bundle:com.example.zhiheng/entry@mine/ets/pages/ProfileComponent";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.MINE_PROFILE:
            import("@bundle:com.example.zhiheng/entry@mine/ets/pages/ProfilePage");
            break;
        case BuilderNameConstants.MINE_ACCOUNT:
            import("@bundle:com.example.zhiheng/entry@mine/ets/pages/AccountPage");
            break;
        default:
            break;
    }
}
