
@Component
export struct ProfilePage {
  build() {
    Scroll() {
      Column() {
        // Status Bar Placeholder (Top "....." and "battery")


        // Header Section
        Column() {
          // Avatar with shadow/border like effect
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(90)
              .height(90)
              .fill('#F0F0F0')
            Image($r('app.media.user_avatar_example'))
              .width(80)
              .height(80)
              .borderRadius(40)
          }
          .margin({ top: 20, bottom: 20 })

          Text('Craig Sheldon')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Row() {
            Text('@sheldon_craig')
              .fontSize(16)
              .fontColor('#B0B0B0')
            

          }
          .margin({ top: 8, bottom: 30 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 30, right: 30 })

        // Cards Section
        Grid() {
          // Resume Card
          GridItem() {
            Column() {
              Image($r('app.media.profile')) // Megaphone icon placeholder
                .width(28)
                .height(28)
                .margin({ bottom: 25 })
                .fillColor('#FFFFFF')
              
              Text('简历')
                .fontSize(22)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('2 份简历待投递面试')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#1EC18D')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
          }
          .columnStart(0)
          .columnEnd(1)

          // Security Card
          GridItem() {
            Column() {
              Image($r('app.media.account')) // Lock icon placeholder
                .width(28)
                .height(28)
                .margin({ bottom: 25 })
                .fillColor('#FFFFFF')
              
              Text('账号与安全')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('Authentication')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#0D8E81')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
          }

          // Docs Card
          GridItem() {
            Column() {
              Image($r('app.media.about_us')) // Doc icon placeholder
                .width(28)
                .height(28)
                .margin({ bottom: 25 })
                .fillColor('#FFFFFF')
              
              Text('关于我们')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('2 documents')
                .fontSize(14)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#0D7174')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
          }
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .columnsGap(15)
        .rowsGap(15)
        .aspectRatio(1)
        .padding({ left: 30, right: 30 })
      }
      .width('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
