import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { AuthService } from '@ohos/auth';
import { HttpResponse, HttpUtil } from '@ohos/network';
import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { User } from '@ohos/auth';


@Component
export struct LoginComponent {
  @State account: string = '';
  @State password: string = '';
  @State isAgreed: boolean = false;
  private context = getContext(this) as common.UIAbilityContext;

  build() {
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
          Text('跳过')
            .fontSize(16)
            .fontColor('#333333')
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
            // .type(InputType.Number)
            // .maxLength(10)
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
            .maxLength(15)
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

          // 登录按钮
          Button() {
            Text('登录')
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
              // 1. 组装请求参数 (根据后端文档的 LoginReqDTO)
              // ArkTS 要求对象字面量必须有明确的类型声明
              const loginReq: Record<string, string> = {
                "accountId": this.account,
                "password": this.password
              };

              // 2. 发起真实的 POST 登录请求
              // 注意：后端的实际登录接口是 /api/user/service/login
              const apiUrl = ':10020/api/user/service/login';

              // 注意：我们在 HttpUtil 中把整个 HttpResponse 当作泛型返回了，所以这里可以直接拿到带有 token 的对象
              // 登录接口返回的 data 通常是一个对象，而不是数组
              hilog.debug(0,'LoginComponent', 'LoginTest1')

              const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(apiUrl, loginReq);
              hilog.debug(0, 'LoginComponent', `登录接口原始响应: ${JSON.stringify(response)}`)
              hilog.debug(0,'LoginComponent', 'LoginTest2')

              // 3. 从响应中提取 token 和用户信息
              const fetchedToken = response.token as string;
              const userData = response.data;

              if (fetchedToken) {
                // 如果成功获取到 token，将其保存到本地首选项并更新内存状态
                // 尝试从响应中获取更多用户信息，如果没有则用 accountId 作为默认用户名
                const user: User = {
                  id: userData && userData['accountId'] ? String(userData['accountId']) : '',
                  // 这里有个常见坑：如果后端返回的数据中 nickName 是空字符串 "" 或者没有这个字段，它会 fallback 到 this.account
                  // 建议确保后端在登录时确实返回了正确的 nickName
                  username: userData && userData['nickName'] ? String(userData['nickName']) : '',
                  avatarUrl: userData && userData['avatar'] ? String(userData['avatar']) : '',
                  token: fetchedToken
                };
                await AuthService.login(this.context, fetchedToken, user);
                // 登录成功后，跳转回上一页 (或首页)
                RouterModule.pop(RouterNameConstants.ENTRY_HAP);
                hilog.debug(0, 'LoginTest', `登录成功，Token ${fetchedToken}`)
              } else {
                hilog.error(0, 'LoginTest', '登录失败 Login Failed: Token not found in response');
              }

            } catch (err) {
              // 修改后
              const error: Error = err as Error;
              // 很多内置的 Error 对象（包括网络错误）在使用 JSON.stringify 时可能序列化出 {}，
              // 因此最好显式打印 error.message 和 error.stack
              hilog.error(0, 'LoginTest',
                '登录失败  Login Failed or Network error: message: %{public}s, stack: %{public}s', error.message,
                error.stack);

              // 如果网络请求失败，这里暂时不跳转，只在控制台报错
              // (如果你想继续无感测试，可以把下面的注释打开)
              // await AuthService.login(this.context, "");
              // RouterModule.pop(RouterNameConstants.ENTRY_HAP);
            }
          })
        }
        .width('100%')
        .padding({ left: 30, right: 30 })
        .margin({ bottom: 40 })

        // 注册按钮 (原账号登录位置)
        Text('注册账号')
          .fontSize(15)
          .fontColor('#666666')
          .padding(10)
          .margin({ bottom: 30 })
          .onClick(() => {
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_REGISTER);
          })

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
