import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';

import image from '@ohos.multimedia.image';

@Component
export struct RegisterComponent {

  @State account: string = '';
  @State password: string = '';
  @State isAgreed: boolean = false;
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
            Text('<')
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
              .type(InputType.Number)
              .maxLength(10)
              .fontSize(16)
              .height(54)
              .backgroundColor('#FFFFFF')
              .borderRadius(27)
              .padding({ left: 20, right: 20 })
              .border({ width: 1, color: '#EEEEEE' })
              .shadow({ radius: 10, color: '#05000000', offsetX: 0, offsetY: 2 })
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
              .shadow({ radius: 10, color: '#05000000', offsetX: 0, offsetY: 2 })
              .onChange((value: string) => {
                this.password = value;
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
            .shadow({ radius: 10, color: '#401EC18D', offsetX: 0, offsetY: 4 })
            .onClick(() => {
              // TODO: 调用注册接口
              RouterModule.pop(RouterNameConstants.ENTRY_HAP);
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