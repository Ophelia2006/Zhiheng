import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export function harBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Column.create();
                Column.width('100%');
                Column.height('100%');
            }, Column);
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554450, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HARB_B3);
                });
            }, Button);
            Button.pop();
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554449, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    RouterModule.pop(RouterNameConstants.ENTRY_HAP);
                });
            }, Button);
            Button.pop();
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554448, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HARB_B1);
                });
            }, Button);
            Button.pop();
            Column.pop();
        }, { moduleName: "entry", pagePath: "report/src/main/ets/components/mainpage/B2" });
        NavDestination.title('B2Page');
        NavDestination.onBackPressed(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            return true;
        });
    }, NavDestination);
    NavDestination.pop();
}
const builderName = BuilderNameConstants.HARB_B2;
if (!RouterModule.getBuilder(builderName)) {
    let builder: WrappedBuilder<[
        object
    ]> = wrapBuilder(harBuilder);
    RouterModule.registerBuilder(builderName, builder);
}
