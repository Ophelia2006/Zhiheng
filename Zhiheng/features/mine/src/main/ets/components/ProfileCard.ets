import { hilog } from '@kit.PerformanceAnalysisKit';

@Reusable
@Component
export struct ProfileCard {
  @State title: string = '';
  @State date: string = '';

  // 必须实现 aboutToReuse 生命周期来更新复用组件的数据
  aboutToReuse(params: Record<string, Object>) {
    this.title = params.title as string;
    this.date = params.date as string;
    hilog.debug(0,'ReuseTest',`[复用组件] 触发复用，更新数据为: ${this.title}`)
  }

  aboutToRecycle(): void {
    hilog.debug(0,'ReuseTest',`[回收组件] 卡片滑出屏幕，被回收池收编了: ${this.title}`)
  }

  build() {

    Row() {
      Column() {
        Text( this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 6 })
        Text(this.date)
          .fontSize(14)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Image($r('app.media.right_arrow'))
        .width(16)
        .height(16)
        .fillColor('#CCCCCC')
        .margin({ left: 10 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 5, color: '#0F000000', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: '#F0F0F0' })

  }
}