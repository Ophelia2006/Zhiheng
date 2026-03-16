
@Component
export struct ReportPage {

  build() {
    Column() {
      Row(){
        Text('面试记录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .letterSpacing(1)
      }
      .width('100%')
      .padding({ left: 25, top: 20, bottom: 10 })
      .backgroundColor('#FFFFFF')



      // List Content
      List({ space: 15 }) {
        ListItem() {
          this.ListItemBuilder('Mar', '22', 'Java后端模拟面试', '45分')
        }
        ListItem() {
          this.ListItemBuilder('Mar', '12', 'HarmonyOS面试', '34分')
        }
        ListItem() {
          this.ListItemBuilder('Jan', '08', '2024 Roadmap', 'No pending bills')
        }
        ListItem() {
          this.ListItemBuilder('Jan', '08', 'Blood Panel', 'Complete')
        }
        ListItem() {
          this.ListItemBuilder('Jan', '01', 'Intake questionnaire', 'Complete')
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 25, right: 25 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  ListItemBuilder(month: string, day: string, title: string, subtitle: string) {
    Row() {
      // Date Section
      Column() {
        Text(month)
          .fontSize(14)
          .fontColor('#999999')
          .fontWeight(FontWeight.Medium)
        Text(day)
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
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .margin({ bottom: 4 })
        
        Text(subtitle)
          .fontSize(14)
          .fontColor('#999999')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      
      // // Right arrow icon placeholder
      // Image($r('app.media.startIcon'))
      //   .width(12)
      //   .height(12)
      //   .fillColor('#CCCCCC')
      //   .rotate({ angle: -90 })
    }
    .width('100%')
    .padding({ top: 15, bottom: 15 })
    .backgroundColor('#F9F9F9') // Light background for the item like in the image
    .borderRadius(16)
    .padding({ left: 15, right: 15, top: 15, bottom: 15 })
  }
}
