if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface RegisterComponent_Params {
    account?: string;
    password?: string;
    isAgreed?: boolean;
}
import { RouterModule, RouterNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
export class RegisterComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__account = new ObservedPropertySimplePU('', this, "account");
        this.__password = new ObservedPropertySimplePU('', this, "password");
        this.__isAgreed = new ObservedPropertySimplePU(false, this, "isAgreed");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: RegisterComponent_Params) {
        if (params.account !== undefined) {
            this.account = params.account;
        }
        if (params.password !== undefined) {
            this.password = params.password;
        }
        if (params.isAgreed !== undefined) {
            this.isAgreed = params.isAgreed;
        }
    }
    updateStateVars(params: RegisterComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__account.purgeDependencyOnElmtId(rmElmtId);
        this.__password.purgeDependencyOnElmtId(rmElmtId);
        this.__isAgreed.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__account.aboutToBeDeleted();
        this.__password.aboutToBeDeleted();
        this.__isAgreed.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __account: ObservedPropertySimplePU<string>;
    get account() {
        return this.__account.get();
    }
    set account(newValue: string) {
        this.__account.set(newValue);
    }
    private __password: ObservedPropertySimplePU<string>;
    get password() {
        return this.__password.get();
    }
    set password(newValue: string) {
        this.__password.set(newValue);
    }
    private __isAgreed: ObservedPropertySimplePU<boolean>;
    get isAgreed() {
        return this.__isAgreed.get();
    }
    set isAgreed(newValue: boolean) {
        this.__isAgreed.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.TopStart });
            Stack.width('100%');
            Stack.height('100%');
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Background gradient
            Column.create();
            // Background gradient
            Column.width('100%');
            // Background gradient
            Column.height('100%');
            // Background gradient
            Column.linearGradient({
                // direction: GradientDirection.BottomRight,
                colors: [['#E0F7FA', 0.0], ['#F0FDF4', 0.5], ['#FFFFFF', 1.0]]
            });
        }, Column);
        // Background gradient
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.height('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Top Bar
            Row.create();
            // Top Bar
            Row.width('100%');
            // Top Bar
            Row.padding({ left: 20, right: 20, top: 40 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('<');
            Text.fontSize(16);
            Text.fontColor('#333333');
            Text.onClick(() => {
                RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            });
        }, Text);
        Text.pop();
        // Top Bar
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Logo & Title
            Column.create();
            // Logo & Title
            Column.width('100%');
            // Logo & Title
            Column.alignItems(HorizontalAlign.Start);
            // Logo & Title
            Column.padding({ left: 30, top: 60 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('CAREER');
            Text.fontSize(48);
            Text.fontWeight(FontWeight.Bolder);
            Text.fontColor('#000000');
            Text.letterSpacing(2);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('SCALE');
            Text.fontSize(48);
            Text.fontWeight(FontWeight.Bolder);
            Text.fontColor('#000000');
            Text.letterSpacing(2);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.margin({ top: 15 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('职衡');
            Text.fontSize(16);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#000000');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Divider.create();
            Divider.vertical(true);
            Divider.height(14);
            Divider.color('#999999');
            Divider.margin({ left: 8, right: 8 });
        }, Divider);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('你的专属AI面试官');
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.letterSpacing(1);
        }, Text);
        Text.pop();
        Row.pop();
        // Logo & Title
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Blank.create();
        }, Blank);
        Blank.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Input Fields Area
            Column.create({ space: 20 });
            // Input Fields Area
            Column.width('100%');
            // Input Fields Area
            Column.padding({ left: 30, right: 30 });
            // Input Fields Area
            Column.margin({ bottom: 40 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 账号输入框
            TextInput.create({ placeholder: '请输入账号', text: this.account });
            // 账号输入框
            TextInput.type(InputType.Number);
            // 账号输入框
            TextInput.maxLength(10);
            // 账号输入框
            TextInput.fontSize(16);
            // 账号输入框
            TextInput.height(54);
            // 账号输入框
            TextInput.backgroundColor('#FFFFFF');
            // 账号输入框
            TextInput.borderRadius(27);
            // 账号输入框
            TextInput.padding({ left: 20, right: 20 });
            // 账号输入框
            TextInput.border({ width: 1, color: '#EEEEEE' });
            // 账号输入框
            TextInput.shadow({ radius: 10, color: '#05000000', offsetX: 0, offsetY: 2 });
            // 账号输入框
            TextInput.onChange((value: string) => {
                this.account = value;
            });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 密码输入框
            TextInput.create({ placeholder: '请输入密码', text: this.password });
            // 密码输入框
            TextInput.type(InputType.Password);
            // 密码输入框
            TextInput.maxLength(15);
            // 密码输入框
            TextInput.fontSize(16);
            // 密码输入框
            TextInput.height(54);
            // 密码输入框
            TextInput.backgroundColor('#FFFFFF');
            // 密码输入框
            TextInput.borderRadius(27);
            // 密码输入框
            TextInput.padding({ left: 20, right: 20 });
            // 密码输入框
            TextInput.border({ width: 1, color: '#EEEEEE' });
            // 密码输入框
            TextInput.shadow({ radius: 10, color: '#05000000', offsetX: 0, offsetY: 2 });
            // 密码输入框
            TextInput.onChange((value: string) => {
                this.password = value;
            });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 注册按钮
            Button.createWithChild();
            // 注册按钮
            Button.width('100%');
            // 注册按钮
            Button.height(54);
            // 注册按钮
            Button.backgroundColor('#1EC18D');
            // 注册按钮
            Button.borderRadius(27);
            // 注册按钮
            Button.shadow({ radius: 10, color: '#401EC18D', offsetX: 0, offsetY: 4 });
            // 注册按钮
            Button.onClick(() => {
                // TODO: 调用注册接口
                RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            });
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('注册');
            Text.fontSize(18);
            Text.fontColor('#FFFFFF');
            Text.fontWeight(FontWeight.Bold);
        }, Text);
        Text.pop();
        // 注册按钮
        Button.pop();
        // Input Fields Area
        Column.pop();
        Column.pop();
        Stack.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
