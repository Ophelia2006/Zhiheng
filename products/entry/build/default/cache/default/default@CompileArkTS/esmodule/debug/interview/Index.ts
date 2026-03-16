import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { InterviewPage } from "@bundle:com.example.zhiheng/entry@interview/ets/pages/InterviewPage";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.HARA_A1:
            import("@bundle:com.example.zhiheng/entry@interview/ets/pages/introduction");
            break;
        case BuilderNameConstants.HARA_A2:
            import("@bundle:com.example.zhiheng/entry@interview/ets/pages/dialog");
            break;
        default:
            break;
    }
}
