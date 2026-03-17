import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { ProfileComponent } from "@bundle:com.example.zhiheng/entry@mine/ets/pages/ProfileComponent";
export function profileBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            {
                (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                    if (isInitialRender) {
                        let componentCall = new ProfileComponent(parent ? parent : this, {}, undefined, elmtId, () => { }, { page: "features/mine/src/main/ets/pages/ProfilePage.ets", line: 22, col: 5 });
                        ViewPU.create(componentCall);
                        let paramsLambda = () => {
                            return {};
                        };
                        componentCall.paramsGenerator_ = paramsLambda;
                    }
                    else {
                        (parent ? parent : this).updateStateVarsOfChildByElmtId(elmtId, {});
                    }
                }, { name: "ProfileComponent" });
            }
        }, { moduleName: "entry", pagePath: "features/mine/src/main/ets/pages/ProfilePage" });
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.MINE_PROFILE;
if (!RouterModule.getBuilder(builderName)) {
    let builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(profileBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
