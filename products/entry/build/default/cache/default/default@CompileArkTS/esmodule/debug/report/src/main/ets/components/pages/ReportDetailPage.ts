import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { ReportDetailComponent } from "@bundle:com.example.zhiheng/entry@report/ets/components/pages/ReportDetailComponent";
export function detailBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                    if (isInitialRender) {
                        let componentCall = new ReportDetailComponent(parent ? parent : this, {}, undefined, elmtId, () => { }, { page: "features/report/src/main/ets/components/pages/ReportDetailPage.ets", line: 21, col: 5 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {};
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {});
                    }
                }, { name: "ReportDetailComponent" });
            }
        }, { moduleName: "entry", pagePath: "features/report/src/main/ets/components/pages/ReportDetailPage" });
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.REPORT_DETAIL;
if (!RouterModule.getBuilder(builderName)) {
    let builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(detailBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
