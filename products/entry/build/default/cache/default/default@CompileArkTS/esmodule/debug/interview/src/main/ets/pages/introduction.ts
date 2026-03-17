import { BuilderNameConstants, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export function introductionBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => { }, { moduleName: "entry", pagePath: "features/interview/src/main/ets/pages/introduction" });
        NavDestination.title('Interview Introduction');
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.INTERVIEW_INTRODUCTION;
if (!RouterModule.getBuilder(builderName)) {
    const builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(introductionBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
