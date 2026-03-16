import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { ProfilePage } from "@bundle:com.example.zhiheng/entry@mine/ets/components/pages/ProfilePage";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.HARC_C1:
            import("@bundle:com.example.zhiheng/entry@mine/ets/components/pages/personal");
            break;
        case BuilderNameConstants.HARC_C2:
            import("@bundle:com.example.zhiheng/entry@mine/ets/components/pages/account");
            break;
        default:
            break;
    }
}
