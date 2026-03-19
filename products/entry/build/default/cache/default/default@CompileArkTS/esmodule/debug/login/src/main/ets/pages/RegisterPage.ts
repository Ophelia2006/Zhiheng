import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { RegisterComponent } from "@bundle:com.example.zhiheng/entry@login/ets/pages/RegisterComponent";
export function registerBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                    if (isInitialRender) {
                        let componentCall = new RegisterComponent(parent ? parent : this, {}, undefined, elmtId, () => { }, { page: "features/login/src/main/ets/pages/RegisterPage.ets", line: 22, col: 5 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {};
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {});
                    }
                }, { name: "RegisterComponent" });
            }
        }, { moduleName: "entry", pagePath: "features/login/src/main/ets/pages/RegisterPage" });
        NavDestination.hideTitleBar(true);
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.LOGIN_REGISTER;
if (!RouterModule.getBuilder(builderName)) {
    const builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(registerBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
