if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AccountComponent_Params {
    dialogController?: CustomDialogController;
}
interface ChangePasswordDialog_Params {
    controller?: CustomDialogController;
    oldPassword?: string;
    newPassword?: string;
    confirmPassword?: string;
}
import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from "@bundle:com.example.zhiheng/entry@RouterModule/Index";
import { AuthService } from "@bundle:com.example.zhiheng/Auth/Index";
class ChangePasswordDialog extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.controller = undefined;
        this.__oldPassword = new ObservedPropertySimplePU('', this, "oldPassword");
        this.__newPassword = new ObservedPropertySimplePU('', this, "newPassword");
        this.__confirmPassword = new ObservedPropertySimplePU('', this, "confirmPassword");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ChangePasswordDialog_Params) {
        if (params.controller !== undefined) {
            this.controller = params.controller;
        }
        if (params.oldPassword !== undefined) {
            this.oldPassword = params.oldPassword;
        }
        if (params.newPassword !== undefined) {
            this.newPassword = params.newPassword;
        }
        if (params.confirmPassword !== undefined) {
            this.confirmPassword = params.confirmPassword;
        }
    }
    updateStateVars(params: ChangePasswordDialog_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__oldPassword.purgeDependencyOnElmtId(rmElmtId);
        this.__newPassword.purgeDependencyOnElmtId(rmElmtId);
        this.__confirmPassword.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__oldPassword.aboutToBeDeleted();
        this.__newPassword.aboutToBeDeleted();
        this.__confirmPassword.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private controller?: CustomDialogController;
    setController(ctr: CustomDialogController) {
        this.controller = ctr;
    }
    private __oldPassword: ObservedPropertySimplePU<string>;
    get oldPassword() {
        return this.__oldPassword.get();
    }
    set oldPassword(newValue: string) {
        this.__oldPassword.set(newValue);
    }
    private __newPassword: ObservedPropertySimplePU<string>;
    get newPassword() {
        return this.__newPassword.get();
    }
    set newPassword(newValue: string) {
        this.__newPassword.set(newValue);
    }
    private __confirmPassword: ObservedPropertySimplePU<string>;
    get confirmPassword() {
        return this.__confirmPassword.get();
    }
    set confirmPassword(newValue: string) {
        this.__confirmPassword.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(12);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Header
            Row.create();
            // Header
            Row.width('100%');
            // Header
            Row.justifyContent(FlexAlign.Start);
            // Header
            Row.margin({ bottom: 15 });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('修改密码');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
        }, Text);
        Text.pop();
        // Header
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Divider.create();
            Divider.color('#EEEEEE');
            Divider.strokeWidth(1);
            Divider.margin({ bottom: 20 });
        }, Divider);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Inputs
            Column.create({ space: 15 });
            // Inputs
            Column.width('100%');
            // Inputs
            Column.margin({ bottom: 25 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('旧密码');
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.margin({ bottom: 8 });
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入旧密码', text: this.oldPassword });
            TextInput.type(InputType.Password);
            TextInput.showPasswordIcon(true);
            TextInput.height(48);
            TextInput.borderRadius(8);
            TextInput.border({ width: 1, color: '#E0E0E0' });
            TextInput.backgroundColor('#FFFFFF');
            TextInput.onChange((val: string) => { this.oldPassword = val; });
        }, TextInput);
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('新密码');
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.margin({ bottom: 8 });
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请输入新密码', text: this.newPassword });
            TextInput.type(InputType.Password);
            TextInput.showPasswordIcon(true);
            TextInput.height(48);
            TextInput.borderRadius(8);
            TextInput.border({ width: 1, color: '#E0E0E0' });
            TextInput.backgroundColor('#FFFFFF');
            TextInput.onChange((val: string) => { this.newPassword = val; });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('密码长度至少8位，包含字母和数字');
            Text.fontSize(12);
            Text.fontColor('#999999');
            Text.margin({ top: 8 });
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
        }, Text);
        Text.pop();
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('确认新密码');
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.margin({ bottom: 8 });
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '请再次输入新密码', text: this.confirmPassword });
            TextInput.type(InputType.Password);
            TextInput.showPasswordIcon(true);
            TextInput.height(48);
            TextInput.borderRadius(8);
            TextInput.border({ width: 1, color: '#E0E0E0' });
            TextInput.backgroundColor('#FFFFFF');
            TextInput.onChange((val: string) => { this.confirmPassword = val; });
        }, TextInput);
        Column.pop();
        // Inputs
        Column.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Buttons
            Row.create({ space: 15 });
            // Buttons
            Row.width('100%');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('取消');
            Button.layoutWeight(1);
            Button.height(48);
            Button.backgroundColor('#FFFFFF');
            Button.fontColor('#666666');
            Button.border({ width: 1, color: '#E0E0E0' });
            Button.borderRadius(8);
            Button.onClick(() => {
                this.controller?.close();
            });
        }, Button);
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithLabel('确认修改');
            Button.layoutWeight(1);
            Button.height(48);
            Button.backgroundColor('#1EC18D');
            Button.fontColor('#FFFFFF');
            Button.borderRadius(8);
            Button.onClick(() => {
                // TODO: 调用修改密码接口
                this.controller?.close();
            });
        }, Button);
        Button.pop();
        // Buttons
        Row.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
export class AccountComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.dialogController = new CustomDialogController({
            builder: () => {
                let jsDialog = new ChangePasswordDialog(this, {}, undefined, -1, () => { }, { page: "features/mine/src/main/ets/pages/AccountComponent.ets", line: 126, col: 14 });
                jsDialog.setController(this.dialogController);
                ViewPU.create(jsDialog);
                let paramsLambda = () => {
                    return {};
                };
                jsDialog.paramsGenerator_ = paramsLambda;
            },
            alignment: DialogAlignment.Center,
            customStyle: true,
            autoCancel: true
        }, this);
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AccountComponent_Params) {
        if (params.dialogController !== undefined) {
            this.dialogController = params.dialogController;
        }
    }
    updateStateVars(params: AccountComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
    }
    aboutToBeDeleted() {
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private dialogController: CustomDialogController;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.height('100%');
            Column.backgroundColor('#F5F7FA');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Title Bar
            Row.create();
            // Title Bar
            Row.width('100%');
            // Title Bar
            Row.height(56);
            // Title Bar
            Row.padding({ left: 20, right: 20 });
            // Title Bar
            Row.backgroundColor('#FFFFFF');
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554479, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Image.width(20);
            Image.height(20);
            Image.fillColor('#333333');
            Image.rotate({ angle: 180 });
            Image.onClick(() => {
                RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            });
        }, Image);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('账号与安全');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.layoutWeight(1);
            Text.textAlign(TextAlign.Center);
            Text.margin({ right: 20 });
        }, Text);
        Text.pop();
        // Title Bar
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // List Items
            Column.create({ space: 15 });
            // List Items
            Column.width('100%');
            // List Items
            Column.padding(20);
            // List Items
            Column.layoutWeight(1);
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Change Password
            Row.create();
            // Change Password
            Row.width('100%');
            // Change Password
            Row.height(60);
            // Change Password
            Row.padding({ left: 20, right: 20 });
            // Change Password
            Row.backgroundColor('#FFFFFF');
            // Change Password
            Row.borderRadius(12);
            // Change Password
            Row.onClick(() => {
                this.dialogController.open();
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Center });
            Stack.width(24);
            Stack.height(24);
            Stack.margin({ right: 10 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Rect.create({ width: 16, height: 14 });
            Rect.fill('#1EC18D');
            Rect.radius(2);
            Rect.margin({ top: 6 });
        }, Rect);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Circle.create({ width: 10, height: 10 });
            Circle.stroke('#1EC18D');
            Circle.strokeWidth(2);
            Circle.fill('transparent');
            Circle.margin({ bottom: 8 });
        }, Circle);
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('修改密码');
            Text.fontSize(16);
            Text.fontColor('#333333');
            Text.layoutWeight(1);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554479, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Image.width(16);
            Image.height(16);
            Image.fillColor('#CCCCCC');
            Image.rotate({ angle: 0 });
        }, Image);
        // Change Password
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Logout
            Row.create();
            // Logout
            Row.width('100%');
            // Logout
            Row.height(60);
            // Logout
            Row.padding({ left: 20, right: 20 });
            // Logout
            Row.backgroundColor('#FFFFFF');
            // Logout
            Row.borderRadius(12);
            // Logout
            Row.onClick(() => {
                // 修改登录状态为未登录
                AuthService.logout();
                // 先清空路由栈，返回到首页状态
                RouterModule.clear(RouterNameConstants.ENTRY_HAP);
                // 再跳转到登录页
                buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGIN);
            });
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Stack.create({ alignContent: Alignment.Center });
            Stack.width(24);
            Stack.height(24);
            Stack.margin({ right: 10 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Rect.create({ width: 14, height: 14 });
            Rect.stroke('#E53935');
            Rect.strokeWidth(2);
            Rect.fill('transparent');
            Rect.radius(2);
        }, Rect);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Polygon.create();
            Polygon.points([[0, 0], [6, 4], [0, 8]]);
            Polygon.fill('#E53935');
            Polygon.position({ x: 12, y: 8 });
        }, Polygon);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Line.create();
            Line.startPoint([6, 12]);
            Line.endPoint([14, 12]);
            Line.stroke('#E53935');
            Line.strokeWidth(2);
        }, Line);
        Stack.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('退出登录');
            Text.fontSize(16);
            Text.fontColor('#E53935');
            Text.layoutWeight(1);
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Image.create({ "id": 33554479, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Image.width(16);
            Image.height(16);
            Image.fillColor('#E53935');
            Image.rotate({ angle: 0 });
        }, Image);
        // Logout
        Row.pop();
        // List Items
        Column.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
