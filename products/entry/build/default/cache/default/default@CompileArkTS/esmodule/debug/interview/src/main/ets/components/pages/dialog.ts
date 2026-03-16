import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants, } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export function dialogBuilder(value: object, parent = null) {
    const __value__ = value;
    (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
        NavDestination.create(() => {
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Column.create();
                Column.width('100%');
                Column.height('100%');
            }, Column);
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554447, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HARB_B2);
                });
            }, Button);
            Button.pop();
            (parent ? parent : this).observeComponentCreation2((elmtId, isInitialRender, value = __value__) => {
                Button.createWithLabel({ "id": 33554444, "type": 10003, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { stateEffect: true, type: ButtonType.Capsule });
                Button.width('80%');
                Button.height(40);
                Button.margin(20);
                Button.onClick(() => {
                    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.HARA_A1, new Object({ origin: 'A2' }));
                });
            }, Button);
            Button.pop();
            Column.pop();
        }, { moduleName: "entry", pagePath: "features/interview/src/main/ets/components/pages/dialog" });
        NavDestination.title('A2Page');
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
