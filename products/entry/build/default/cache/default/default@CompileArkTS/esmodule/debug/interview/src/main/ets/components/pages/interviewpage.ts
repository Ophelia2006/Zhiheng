if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface InterviewPage_Params {
}
export class InterviewPage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: InterviewPage_Params) {
    }
    updateStateVars(params: InterviewPage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    // @Consume('pageStack') pageStack: NavPathStack;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Bottom });
            Stack.width('100%');
            Stack.height('100%');
            Stack.backgroundColor('#ffffffff');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Overlay Content
            Column.create();
            // Overlay Content
            Column.width('100%');
            // Overlay Content
            Column.height('100%');
            // Overlay Content
            Column.justifyContent(FlexAlign.End);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Bottom Card Section
            Column.create();
            // Bottom Card Section
            Column.width('100%');
            // Bottom Card Section
            Column.backgroundColor({ "id": 33554467, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            // Bottom Card Section
            Column.borderRadius(30);
            // Bottom Card Section
            Column.padding(30);
            // Bottom Card Section
            Column.margin(15);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('你的私人AI面试官');
            Text.fontSize(28);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor(Color.Black);
            Text.textAlign(TextAlign.Start);
            Text.width('100%');
            Text.margin({ bottom: 16 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('添加简历以开启模拟面试');
            Text.fontSize(14);
            Text.fontColor('#AAAAAA');
            Text.textAlign(TextAlign.Start);
            Text.width('100%');
            Text.margin({ bottom: 40 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Start Button
            Row.create();
            // Start Button
            Row.width('100%');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithChild();
            Button.backgroundColor({ "id": 33554462, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Button.borderRadius(30);
            Button.height(60);
            Button.onClick(() => {
                // Navigate to ResumeAddPage
                // Use the provided pageStack to push the new page
                // this.pageStack.pushPathByName(RoutePath.ResumeAddPage, null);
            });
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.padding({ left: 20, right: 5, top: 5, bottom: 5 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('去面试');
            Text.fontSize(14);
            Text.fontWeight(FontWeight.Medium);
            Text.fontColor(Color.White);
            Text.margin({ right: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Arrow Circle
            Stack.create({ alignContent: Alignment.Center });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Circle.create({ width: 40, height: 40 });
            Circle.fill(Color.White);
        }, Circle);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554475, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Image.width(23);
            Image.height(23);
            Image.fillColor('#000000');
        }, Image);
        // Arrow Circle
        Stack.pop();
        Row.pop();
        Button.pop();
        // Start Button
        Row.pop();
        // Bottom Card Section
        Column.pop();
        // Overlay Content
        Column.pop();
        Stack.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
