import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { InterviewPage } from "@bundle:com.example.zhiheng/entry@interview/ets/pages/InterviewPage";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.INTERVIEW_INTRODUCTION:
            import("@bundle:com.example.zhiheng/entry@interview/ets/pages/introduction");
            break;
        case BuilderNameConstants.INTERVIEW_DIALOG:
            import("@bundle:com.example.zhiheng/entry@interview/ets/pages/dialog");
            break;
        default:
            break;
    }
}
