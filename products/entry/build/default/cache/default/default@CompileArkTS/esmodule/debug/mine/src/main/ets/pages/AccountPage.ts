import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { AccountComponent } from "@bundle:com.example.zhiheng/entry@mine/ets/pages/AccountComponent";
export function accountBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                    if (isInitialRender) {
                        let componentCall = new AccountComponent(parent ? parent : this, {}, undefined, elmtId, () => { }, { page: "features/mine/src/main/ets/pages/AccountPage.ets", line: 21, col: 5 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {};
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {});
                    }
                }, { name: "AccountComponent" });
            }
        }, { moduleName: "entry", pagePath: "features/mine/src/main/ets/pages/AccountPage" });
        NavDestination.hideTitleBar(true);
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.MINE_ACCOUNT;
if (!RouterModule.getBuilder(builderName)) {
    let builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(accountBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
