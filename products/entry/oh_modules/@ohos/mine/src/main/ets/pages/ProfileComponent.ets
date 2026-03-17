import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';


@Component
export struct ProfileComponent {
  build() {
    Column() {

      // 简历列表
      List({ space: 15 }) {
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
        ListItem() {
          this.ResumeCardBuilder('Java后端开发简历', '针对互联网大厂', '#E6F9F0', '#1EC18D')
        }
        ListItem() {
          this.ResumeCardBuilder('HarmonyOS开发', '针对鸿蒙生态企业',  '#FFFBE6', '#FAAD14')
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 20, right: 20 })
      .scrollBar(BarState.Off)

      // 底部按钮区域
      Row() {
        // 手动添加按钮
        Button() {
          Column() {
            // 图标占位
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 24, height: 24 })
                .fill('#333333')
              Text('+')
                .fontSize(16)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .margin({ bottom: 8 })

            Text('手动添加')
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#F0F9F6')
        .borderRadius(16)
        .width(140)
        .height(100)
        .onClick(() => {
          // TODO: 手动添加逻辑
        })

        // 自动导入按钮
        Button() {
          Column() {
            // 图标占位
            Stack({ alignContent: Alignment.Center }) {
              Rect({ width: 18, height: 22 })
                .fill('#333333')
                .radius(2)
              Text('→')
                .fontSize(14)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .margin({ bottom: 8 })

            Text('自动导入')
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#F0F9F6')
        .borderRadius(16)
        .width(140)
        .height(100)
        .onClick(() => {
          // TODO: 自动导入逻辑
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  ResumeCardBuilder(title: string, subtitle: string,  statusBgColor: string, statusColor: string) {
    Row() {
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#333333')
          .margin({ bottom: 6 })
        Text(subtitle)
          .fontSize(14)
          .fontColor('#999999')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 5, color: '#0F000000', offsetX: 0, offsetY: 2 })
    .border({ width: 1, color: '#F0F0F0' })
  }
}
