import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { ResumeAddComponent } from "@bundle:com.example.zhiheng/entry@interview/ets/pages/ResumeAddComponent";
export function dialogBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                    if (isInitialRender) {
                        let componentCall = new ResumeAddComponent(parent ? parent : this, {}, undefined, elmtId, () => { }, { page: "features/interview/src/main/ets/pages/DialogPage.ets", line: 22, col: 5 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {};
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {});
                    }
                }, { name: "ResumeAddComponent" });
            }
        }, { moduleName: "entry", pagePath: "features/interview/src/main/ets/pages/DialogPage" });
        NavDestination.hideTitleBar(true);
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.INTERVIEW_DIALOG;
if (!RouterModule.getBuilder(builderName)) {
    const builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(dialogBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
