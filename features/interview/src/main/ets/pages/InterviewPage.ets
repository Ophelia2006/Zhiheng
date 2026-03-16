import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';


@Component
export struct InterviewPage {
  // @Consume('pageStack') pageStack: NavPathStack;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // Overlay Content
      Column() {
        // Bottom Card Section
        Column() {
          Text('你的私人AI面试官')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Black)
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: 16 })

          Text('添加简历以开启模拟面试')
            .fontSize(14)
            .fontColor('#AAAAAA')
            .textAlign(TextAlign.Start)
            .width('100%')
            .margin({ bottom: 40 })

          // Start Button
          Row() {
            Blank()
            Button() {
              Row() {
                Text('去面试')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.White)
                  .margin({ right: 10 })

                // Arrow Circle
                Stack({ alignContent: Alignment.Center }) {
                  Circle({ width: 40, height: 40 })
                    .fill(Color.White)
                  Image($r('app.media.right_arrow')) // Arrow icon
                    .width(23)
                    .height(23)
                    .fillColor('#000000')
                }
              }
              .padding({
                left: 20,
                right: 5,
                top: 5,
                bottom: 5
              })
            }
            .backgroundColor($r('app.color.green_botton'))
            .borderRadius(30)
            .height(60)
            .onClick(() => {
              // Navigate to ResumeAddPage
              // Use the provided pageStack to push the new page
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.INTERVIEW_DIALOG);
              hilog.debug(0, '12345678', '路由INTERVIEW_DIALOG')
            })
          }
          .width('100%')
        }
        .width('100%')
        .backgroundColor($r('app.color.green_tabs'))
        .borderRadius(30)
        .padding(30)
        .margin(15)
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffffff')
  }
}
