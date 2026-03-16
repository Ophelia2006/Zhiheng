if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface EntryHap_Params {
    entryHapRouter?: NavPathStack;
    currentIndex?: number;
    controller?: TabsController;
}
import { RouterModule, RouterNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { InterviewPage } from "@bundle:com.example.zhiheng/entry@interview/Index";
import { ReportPage } from "@bundle:com.example.zhiheng/entry@report/Index";
import { ProfilePage } from "@bundle:com.example.zhiheng/entry@mine/Index";
class EntryHap extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__entryHapRouter = new ObservedPropertyObjectPU(new NavPathStack(), this, "entryHapRouter");
        this.__currentIndex = new ObservedPropertySimplePU(0, this, "currentIndex");
        this.controller = new TabsController();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: EntryHap_Params) {
        if (params.entryHapRouter !== undefined) {
            this.entryHapRouter = params.entryHapRouter;
        }
        if (params.currentIndex !== undefined) {
            this.currentIndex = params.currentIndex;
        }
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
    }
    updateStateVars(params: EntryHap_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__entryHapRouter.purgeDependencyOnElmtId(rmElmtId);
        this.__currentIndex.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__entryHapRouter.aboutToBeDeleted();
        this.__currentIndex.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __entryHapRouter: ObservedPropertyObjectPU<NavPathStack>;
    get entryHapRouter() {
        return this.__entryHapRouter.get();
    }
    set entryHapRouter(newValue: NavPathStack) {
        this.__entryHapRouter.set(newValue);
    }
    private __currentIndex: ObservedPropertySimplePU<number>;
    get currentIndex() {
        return this.__currentIndex.get();
    }
    set currentIndex(newValue: number) {
        this.__currentIndex.set(newValue);
    }
    private controller: TabsController;
    TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.height(50);
            Column.justifyContent(FlexAlign.Center);
            Column.onClick(() => {
                this.currentIndex = targetIndex;
                this.controller.changeIndex(targetIndex);
            });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create(this.currentIndex === targetIndex ? selectedImg : normalImg);
            Image.size({ width: 25, height: 25 });
            Image.fillColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a');
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(title);
            Text.fontColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a');
        }, Text);
        Text.pop();
        Column.pop();
    }
    aboutToAppear() {
        if (!this.entryHapRouter) {
            this.entryHapRouter = new NavPathStack();
        }
        RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.entryHapRouter);
    }
    routerMap(builderName: string, param: object, parent = null) {
        // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
        RouterModule.getBuilder(builderName).builder.bind(this)(param);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Navigation.create(this.entryHapRouter, { moduleName: "entry", pagePath: "products/entry/src/main/ets/pages/Index", isUserCreateStack: true });
            Navigation.navDestination({ builder: this.routerMap.bind(this) });
        }, Navigation);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Tabs.create({ barPosition: BarPosition.End, controller: this.controller });
            Tabs.onChange((index: number) => {
                this.currentIndex = index;
            });
        }, Tabs);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new InterviewPage(this, {}, undefined, elmtId, () => { }, { page: "products/entry/src/main/ets/pages/Index.ets", line: 68, col: 13 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "InterviewPage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, '面试', 0, { "id": 33554453, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { "id": 33554454, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                } });
        }, TabContent);
        TabContent.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new ReportPage(this, {}, undefined, elmtId, () => { }, { page: "products/entry/src/main/ets/pages/Index.ets", line: 73, col: 13 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "ReportPage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, '报告', 1, { "id": 33554457, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { "id": 33554458, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                } });
        }, TabContent);
        TabContent.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TabContent.create(() => {
                {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        if (isInitialRender) {
                            let componentCall = new ProfilePage(this, {}, undefined, elmtId, () => { }, { page: "products/entry/src/main/ets/pages/Index.ets", line: 78, col: 13 });
                            ViewPU.create(componentCall);
                            let paramsLambda = () => {
                                return {};
                            };
                            componentCall.paramsGenerator_ = paramsLambda;
                        }
                        else {
                            this.updateStateVarsOfChildByElmtId(elmtId, {});
                        }
                    }, { name: "ProfilePage" });
                }
            });
            TabContent.tabBar({ builder: () => {
                    this.TabBuilder.call(this, '我的', 2, { "id": 33554455, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, { "id": 33554456, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                } });
        }, TabContent);
        TabContent.pop();
        Tabs.pop();
        Column.pop();
        Navigation.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
    static getEntryName(): string {
        return "EntryHap";
    }
}
registerNamedRoute(() => new EntryHap(undefined, {}), "", { bundleName: "com.example.zhiheng", moduleName: "entry", pagePath: "pages/Index", pageFullPath: "products/entry/src/main/ets/pages/Index", integratedHsp: "false", moduleType: "followWithHap" });
