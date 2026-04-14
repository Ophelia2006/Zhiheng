import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { HttpUtil } from '@ohos/network';
import image from '@ohos.multimedia.image';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { AuthService } from '@ohos/auth';
import { common } from '@kit.AbilityKit';
import { User } from '@ohos/auth';

@Component
export struct RegisterComponent {
  @State account: string = '';
  @State password: string = '';
  @State nickName: string = ''; // 新增昵称状态
  @State isAgreed: boolean = false;
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {

      Stack({ alignContent: Alignment.TopStart }) {
        // Background gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            // direction: GradientDirection.BottomRight,
            colors: [['#E0F7FA', 0.0], ['#F0FDF4', 0.5], ['#FFFFFF', 1.0]]
          })

        Column() {
          // Top Bar
          Row() {
            Image($r('app.media.left_arrow'))
              .width(24)
              .height(24)
              .onClick(() => {
                RouterModule.pop(RouterNameConstants.ENTRY_HAP);
              })


          }
          .width('100%')
          .padding({ left: 20, right: 20, top: 40 })

          // Logo & Title
          Column() {
            Text('CAREER')
              .fontSize(48)
              .fontWeight(FontWeight.Bolder)
              .fontColor('#000000')
              .letterSpacing(2)
            Text('SCALE')
              .fontSize(48)
              .fontWeight(FontWeight.Bolder)
              .fontColor('#000000')
              .letterSpacing(2)

            Row() {
              Text('职衡')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#000000')
              Divider()
                .vertical(true)
                .height(14)
                .color('#999999')
                .margin({ left: 8, right: 8 })
              Text('你的专属AI面试官')
                .fontSize(14)
                .fontColor('#666666')
                .letterSpacing(1)
            }
            .margin({ top: 15 })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
          .padding({ left: 30, top: 60 })

          Blank()

          // Input Fields Area
          Column({ space: 20 }) {
            // 账号输入框
            TextInput({ placeholder: '请输入账号', text: this.account })
              .type(InputType.Email) // 根据文档，账号通常是邮箱格式
              .maxLength(50)
              .fontSize(16)
              .height(54)
              .backgroundColor('#FFFFFF')
              .borderRadius(27)
              .padding({ left: 20, right: 20 })
              .border({ width: 1, color: '#EEEEEE' })
              .shadow({
                radius: 10,
                color: '#05000000',
                offsetX: 0,
                offsetY: 2
              })
              .onChange((value: string) => {
                this.account = value;
              })

            // 密码输入框
            TextInput({ placeholder: '请输入密码', text: this.password })
              .type(InputType.Password)
              .maxLength(20)
              .fontSize(16)
              .height(54)
              .backgroundColor('#FFFFFF')
              .borderRadius(27)
              .padding({ left: 20, right: 20 })
              .border({ width: 1, color: '#EEEEEE' })
              .shadow({
                radius: 10,
                color: '#05000000',
                offsetX: 0,
                offsetY: 2
              })
              .onChange((value: string) => {
                this.password = value;
              })

            // 昵称输入框 (新增，满足后端 SignUpReqDTO 需求)
            TextInput({ placeholder: '请输入昵称', text: this.nickName })
              .type(InputType.Normal)
              .maxLength(20)
              .fontSize(16)
              .height(54)
              .backgroundColor('#FFFFFF')
              .borderRadius(27)
              .padding({ left: 20, right: 20 })
              .border({ width: 1, color: '#EEEEEE' })
              .shadow({
                radius: 10,
                color: '#05000000',
                offsetX: 0,
                offsetY: 2
              })
              .onChange((value: string) => {
                this.nickName = value;
              })

            // 注册按钮
            Button() {
              Text('注册')
                .fontSize(18)
                .fontColor('#FFFFFF')
                .fontWeight(FontWeight.Bold)
            }
            .width('100%')
            .height(54)
            .backgroundColor('#1EC18D')
            .borderRadius(27)
            .shadow({
              radius: 10,
              color: '#401EC18D',
              offsetX: 0,
              offsetY: 4
            })
            .onClick(async () => {
              try {
                // 1. 组装注册请求参数 (根据后端文档 SignUpReqDTO)
                const signUpReq: Record<string, string> = {
                  "accountId": this.account,
                  "password": this.password,
                  "nickName": this.nickName
                };

                // 2. 发起真实的 POST 注册请求
                const registerUrl = ':10020/api/user/service/sign/up';
                // 注册接口返回的数据不需要拿 token，因为返回的 token 是空的
                await HttpUtil.post<Record<string, Object>>(registerUrl, signUpReq);

                hilog.info(0x0000, 'RegisterTest', '注册成功，准备执行静默登录');

                // 3. 注册成功后，执行静默登录 (自动用刚才注册的账号密码请求登录接口)
                const loginReq: Record<string, string> = {
                  "accountId": this.account,
                  "password": this.password
                };
                const loginUrl = ':10020/api/user/service/login';
                const loginResponse = await HttpUtil.post<Record<string, Object>>(loginUrl, loginReq);

                // 4. 从登录响应中提取 token
                const fetchedToken = loginResponse.token as string;

                if (fetchedToken) {
                  // 保存 Token 并更新登录状态，同时将注册时的用户信息传给 AuthService
                  const user: User = {
                    id: this.account,
                    username: this.nickName || this.account,
                    avatarUrl: '',
                    token: fetchedToken
                  };
                  await AuthService.login(this.context, fetchedToken, user);
                  hilog.info(0x0000, 'RegisterTest', `静默登录成功，Token: ${fetchedToken}`);

                  // 5. 注册并登录成功后，跳转回上一页 (或首页)
                  RouterModule.pop(RouterNameConstants.ENTRY_HAP);
                  RouterModule.pop(RouterNameConstants.ENTRY_HAP);
                } else {
                  hilog.error(0x0000, 'RegisterTest', '静默登录失败: 未获取到 Token');
                  // 这里可以弹窗提示用户手动登录，然后跳转到登录页
                }

              } catch (err) {
                const error: Error = err as Error;
                hilog.error(0, 'LoginTest',
                  '注册或登录失败  Login Failed or Network error: message: %{public}s, stack: %{public}s',
                  error.message, error.stack);

                // TODO: 可以在这里添加 Toast 提示用户，比如 "该账号已被注册"
              }
            })
          }
          .width('100%')
          .padding({ left: 30, right: 30 })
          .margin({ bottom: 40 })


          // // Agreement
          // Row() {
          //   Checkbox({ name: 'agreement', group: 'loginGroup' })
          //     .select(this.isAgreed)
          //     .selectedColor('#333333')
          //     .width(16)
          //     .height(16)
          //     .onChange((value: boolean) => {
          //       this.isAgreed = value;
          //     })
          //
          //   Text() {
          //     Span('我已阅读并同意')
          //       .fontColor('#999999')
          //     Span('《用户注册协议》')
          //       .fontColor('#6688AA')
          //     Span('和')
          //       .fontColor('#999999')
          //     Span('《职衡平台隐私政策》')
          //       .fontColor('#6688AA')
          //   }
          //   .fontSize(12)
          //   .margin({ left: 8 })
          // }
          // .width('100%')
          // .justifyContent(FlexAlign.Center)
          // .margin({ bottom: 40 })

        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
    }
  }
}