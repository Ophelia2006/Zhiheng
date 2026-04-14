import { ReportCardModel } from '@ohos/model/src/main/ets/InterviewReport';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Reusable
@Component
export struct ReportCard {
  @State month: string = '';
  @State day: string = '';
  @State title: string = '';
  @State score: string = '';

  // 必须实现 aboutToReuse 生命周期来更新复用组件的数据
  aboutToReuse(params: Record<string, Object>) {
    this.month = params.month as string;
    this.day = params.day as string;
    this.title = params.title as string;
    this.score = params.score as string;
    hilog.debug(0,'ReuseTest',`[复用组件] 触发复用，更新数据为: ${this.title}`)
  }

  aboutToRecycle(): void {
    hilog.debug(0,'ReuseTest',`[回收组件] 卡片滑出屏幕，被回收池收编了: ${this.title}`)
  }

  build() {


    Row() {
      // Date Section
      Column() {
        Text(this.month)
          .fontSize(14)
          .fontColor('#999999')
          .fontWeight(FontWeight.Medium)
        Text(this.day)
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
      }
      .width(50)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)

      // Vertical Divider
      Divider()
        .vertical(true)
        .height(30)
        .color('#E0E0E0')
        .strokeWidth(1)
        .margin({ left: 10, right: 15 })

      // Content Section
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .margin({ bottom: 4 })

        Text(this.score)
          .fontSize(14)
          .fontColor('#999999')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Right arrow icon
      Image($r('app.media.right_arrow'))
        .width(16)
        .height(16)
        .fillColor('#CCCCCC')
    }
    .width('100%')
    .padding({ top: 15, bottom: 15 })
    .backgroundColor('#F9F9F9') // Light background for the item like in the image
    .borderRadius(16)
    .padding({ left: 15, right: 15, top: 15, bottom: 15 })
  }
}