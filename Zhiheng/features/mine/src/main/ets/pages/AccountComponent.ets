import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { AuthService } from '@ohos/auth';
import { common } from '@kit.AbilityKit';
import { HttpResponse, HttpUtil } from '@ohos/network'
import { hilog } from '@kit.PerformanceAnalysisKit';

@CustomDialog
struct ChangePasswordDialog {
  controller?: CustomDialogController
  @State oldPassword: string = ''
  @State newPassword: string = ''
  @State confirmPassword: string = ''

  build() {
    Column() {
      // Header
      Row() {
        Text('修改密码')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width('100%')
      .justifyContent(FlexAlign.Start)
      .margin({ bottom: 15 })

      Divider().color('#EEEEEE').strokeWidth(1).margin({ bottom: 20 })

      // Inputs
      Column({ space: 15 }) {
        Column() {
          Text('旧密码')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
          TextInput({ placeholder: '请输入旧密码', text: this.oldPassword })
            .type(InputType.Password)
            .showPasswordIcon(true)
            .height(48)
            .borderRadius(8)
            .border({ width: 1, color: '#E0E0E0' })
            .backgroundColor('#FFFFFF')
            .onChange((val: string) => {
              this.oldPassword = val
            })
        }

        Column() {
          Text('新密码')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
          TextInput({ placeholder: '请输入新密码', text: this.newPassword })
            .type(InputType.Password)
            .showPasswordIcon(true)
            .height(48)
            .borderRadius(8)
            .border({ width: 1, color: '#E0E0E0' })
            .backgroundColor('#FFFFFF')
            .onChange((val: string) => {
              this.newPassword = val
            })

          Text('密码长度至少8位，包含字母和数字')
            .fontSize(12)
            .fontColor('#999999')
            .margin({ top: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
        }

        Column() {
          Text('确认新密码')
            .fontSize(14)
            .fontColor('#666666')
            .margin({ bottom: 8 })
            .width('100%')
            .textAlign(TextAlign.Start)
          TextInput({ placeholder: '请再次输入新密码', text: this.confirmPassword })
            .type(InputType.Password)
            .showPasswordIcon(true)
            .height(48)
            .borderRadius(8)
            .border({ width: 1, color: '#E0E0E0' })
            .backgroundColor('#FFFFFF')
            .onChange((val: string) => {
              this.confirmPassword = val
            })
        }
      }
      .width('100%')
      .margin({ bottom: 25 })

      // Buttons
      Row({ space: 15 }) {
        Button('取消')
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#FFFFFF')
          .fontColor('#666666')
          .border({ width: 1, color: '#E0E0E0' })
          .borderRadius(8)
          .onClick(() => {
            this.controller?.close()
          })

        Button('确认修改')
          .layoutWeight(1)
          .height(48)
          .backgroundColor('#1EC18D')
          .fontColor('#FFFFFF')
          .borderRadius(8)
          .onClick(() => {
            // TODO: 调用修改密码接口
            this.controller?.close()
          })
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}

@Component
export struct AccountComponent {
  dialogController: CustomDialogController = new CustomDialogController({
    builder: ChangePasswordDialog(),
    alignment: DialogAlignment.Center,
    customStyle: true,
    autoCancel: true
  })

  build() {
    Column() {
      // Title Bar
      Row() {
        Image($r('app.media.left_arrow')) // 左箭头
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
          })

        Text('账号与安全')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
          .margin({ right: 20 }) // Balance the back button for centering
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#FFFFFF')

      // List Items
      Column({ space: 15 }) {
        // Change Password
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Rect({ width: 16, height: 14 }).fill('#1EC18D').radius(2).margin({ top: 6 })
            Circle({ width: 10, height: 10 }).stroke('#1EC18D').strokeWidth(2).fill('transparent').margin({ bottom: 8 })
          }.width(24).height(24).margin({ right: 10 })

          Text('修改密码')
            .fontSize(16)
            .fontColor('#333333')
            .layoutWeight(1)

          Image($r('app.media.right_arrow')) // 右箭头
            .width(16)
            .height(16)
            .fillColor('#CCCCCC')
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20 })
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .onClick(() => {
          this.dialogController.open()
        })

        // Logout
        Row() {
          Stack({ alignContent: Alignment.Center }) {
            Rect({ width: 14, height: 14 }).stroke('#E53935').strokeWidth(2).fill('transparent').radius(2)
            Polygon().points([[0, 0], [6, 4], [0, 8]]).fill('#E53935').position({ x: 12, y: 8 })
            Line().startPoint([6, 12]).endPoint([14, 12]).stroke('#E53935').strokeWidth(2)
          }.width(24).height(24).margin({ right: 10 })

          Text('退出登录')
            .fontSize(16)
            .fontColor('#E53935')
            .layoutWeight(1)

          Image($r('app.media.right_arrow')) // 右箭头
            .width(16)
            .height(16)
            .fillColor('#E53935')
        }
        .width('100%')
        .height(60)
        .padding({ left: 20, right: 20 })
        .backgroundColor('#FFFFFF')
        .borderRadius(12)
        .onClick(async () => {
          try {
            // 1. 在清理本地状态之前，先拿到当前登录用户的 ID
            const user = AuthService.getUser();
            const userId = user?.id || '';

            // 2. 组装请求参数（根据后端文档，将 userId 放入请求体中）
            const logoutReq: Record<string, string> = {
              "userId": userId
            };

            // 3. 发起真实的登出请求
            const apiUrl = ':10020/api/user/service/logout';
            const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(apiUrl, logoutReq);
            hilog.debug(0, 'AccountComponent', `登出响应: ${JSON.stringify(response)}`);

          } catch (err) {
            // 即使网络请求失败（比如断网或 Token 已过期），也不要阻止本地登出
            hilog.error(0, 'AccountComponent', `登出请求失败，但继续清理本地状态: ${err}`);
          } finally {
            // 4. 无论请求成功与否，必须执行本地清理
            const context = getContext(this) as common.UIAbilityContext;
            AuthService.logout(context);

            // 5. 路由跳转：清空栈并回到登录页
            RouterModule.clear(RouterNameConstants.ENTRY_HAP);
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGIN);
          }
        })
      }
      .width('100%')
      .padding(20)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA') // Light gray background
  }
}