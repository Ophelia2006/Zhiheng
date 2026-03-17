import { BuilderNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export { ReportPage } from "@bundle:com.example.zhiheng/entry@report/ets/components/pages/ReportPage";
export function harInit(builderName: string): void {
    // 动态引入要跳转的页面
    switch (builderName) {
        case BuilderNameConstants.HARB_B1:
            import("@bundle:com.example.zhiheng/entry@report/ets/components/pages/list");
            break;
        case BuilderNameConstants.REPORT_DETAIL:
            import("@bundle:com.example.zhiheng/entry@report/ets/components/pages/ReportDetailPage");
            break;
        case BuilderNameConstants.HARB_B3:
            import("@bundle:com.example.zhiheng/entry@report/ets/components/pages/B3");
            break;
        default:
            break;
    }
}
