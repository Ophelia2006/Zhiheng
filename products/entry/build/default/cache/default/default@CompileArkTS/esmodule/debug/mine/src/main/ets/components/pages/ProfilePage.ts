if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ProfilePage_Params {
}
export class ProfilePage extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ProfilePage_Params) {
    }
    updateStateVars(params: ProfilePage_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.width('100%');
            Scroll.height('100%');
            Scroll.backgroundColor('#FFFFFF');
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Status Bar Placeholder (Top "....." and "battery")
            // Header Section
            Column.create();
            // Status Bar Placeholder (Top "....." and "battery")
            // Header Section
            Column.width('100%');
            // Status Bar Placeholder (Top "....." and "battery")
            // Header Section
            Column.alignItems(HorizontalAlign.Start);
            // Status Bar Placeholder (Top "....." and "battery")
            // Header Section
            Column.padding({ left: 30, right: 30 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Avatar with shadow/border like effect
            Stack.create({ alignContent: Alignment.Center });
            // Avatar with shadow/border like effect
            Stack.margin({ top: 20, bottom: 20 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Circle.create();
            Circle.width(90);
            Circle.height(90);
            Circle.fill('#F0F0F0');
        }, Circle);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554479, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Image.width(80);
            Image.height(80);
            Image.borderRadius(40);
        }, Image);
        // Avatar with shadow/border like effect
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('Craig Sheldon');
            Text.fontSize(32);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#1A1A1A');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: 8, bottom: 30 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('@sheldon_craig');
            Text.fontSize(16);
            Text.fontColor('#B0B0B0');
        }, Text);
        Text.pop();
        Row.pop();
        // Status Bar Placeholder (Top "....." and "battery")
        // Header Section
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Cards Section
            Grid.create();
            // Cards Section
            Grid.width('100%');
            // Cards Section
            Grid.columnsTemplate('1fr 1fr');
            // Cards Section
            Grid.rowsTemplate('1fr 1fr');
            // Cards Section
            Grid.columnsGap(15);
            // Cards Section
            Grid.rowsGap(15);
            // Cards Section
            Grid.aspectRatio(1);
            // Cards Section
            Grid.padding({ left: 30, right: 30 });
        }, Grid);
        {
            const itemCreation2 = (elmtId, isInitialRender) => {
                GridItem.create(() => { }, false);
                // Resume Card
                GridItem.columnStart(0);
                // Resume Card
                GridItem.columnEnd(1);
            };
            const observedDeepRender = () => {
                this.observeComponentCreation2(itemCreation2, GridItem);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width('100%');
                    Column.height('100%');
                    Column.backgroundColor('#1EC18D');
                    Column.borderRadius(25);
                    Column.padding(25);
                    Column.alignItems(HorizontalAlign.Start);
                    Column.justifyContent(FlexAlign.Start);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 33554478, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                    Image.width(28);
                    Image.height(28);
                    Image.margin({ bottom: 25 });
                    Image.fillColor('#FFFFFF');
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('简历');
                    Text.fontSize(22);
                    Text.fontWeight(FontWeight.Bold);
                    Text.fontColor('#FFFFFF');
                    Text.margin({ bottom: 4 });
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('2 份简历待投递面试');
                    Text.fontSize(14);
                    Text.fontColor('#FFFFFF');
                    Text.opacity(0.8);
                }, Text);
                Text.pop();
                Column.pop();
                // Resume Card
                GridItem.pop();
            };
            observedDeepRender();
        }
        {
            const itemCreation2 = (elmtId, isInitialRender) => {
                GridItem.create(() => { }, false);
            };
            const observedDeepRender = () => {
                this.observeComponentCreation2(itemCreation2, GridItem);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width('100%');
                    Column.height('100%');
                    Column.backgroundColor('#0D8E81');
                    Column.borderRadius(25);
                    Column.padding(25);
                    Column.alignItems(HorizontalAlign.Start);
                    Column.justifyContent(FlexAlign.Start);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 33554477, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                    Image.width(28);
                    Image.height(28);
                    Image.margin({ bottom: 25 });
                    Image.fillColor('#FFFFFF');
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('账号与安全');
                    Text.fontSize(20);
                    Text.fontWeight(FontWeight.Bold);
                    Text.fontColor('#FFFFFF');
                    Text.margin({ bottom: 4 });
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('Authentication');
                    Text.fontSize(14);
                    Text.fontColor('#FFFFFF');
                    Text.opacity(0.8);
                }, Text);
                Text.pop();
                Column.pop();
                // Security Card
                GridItem.pop();
            };
            observedDeepRender();
        }
        {
            const itemCreation2 = (elmtId, isInitialRender) => {
                GridItem.create(() => { }, false);
            };
            const observedDeepRender = () => {
                this.observeComponentCreation2(itemCreation2, GridItem);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width('100%');
                    Column.height('100%');
                    Column.backgroundColor('#0D7174');
                    Column.borderRadius(25);
                    Column.padding(25);
                    Column.alignItems(HorizontalAlign.Start);
                    Column.justifyContent(FlexAlign.Start);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Image.create({ "id": 33554476, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                    Image.width(28);
                    Image.height(28);
                    Image.margin({ bottom: 25 });
                    Image.fillColor('#FFFFFF');
                }, Image);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('关于我们');
                    Text.fontSize(20);
                    Text.fontWeight(FontWeight.Bold);
                    Text.fontColor('#FFFFFF');
                    Text.margin({ bottom: 4 });
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create('2 documents');
                    Text.fontSize(14);
                    Text.fontColor('#FFFFFF');
                    Text.opacity(0.8);
                }, Text);
                Text.pop();
                Column.pop();
                // Docs Card
                GridItem.pop();
            };
            observedDeepRender();
        }
        // Cards Section
        Grid.pop();
        Column.pop();
        Scroll.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
