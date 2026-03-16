import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export function personalBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Column.create();
                Column.width('100%');
                Column.height('100%');
            }, Column);
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554452, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HARC_C2);
                });
            }, Button);
            Button.pop();
            Column.pop();
        }, { moduleName: "entry", pagePath: "features/mine/src/main/ets/components/pages/personal" });
        NavDestination.title('C1Page');
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.MINE_PERSONAL;
if (!RouterModule.getBuilder(builderName)) {
    let builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(personalBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
