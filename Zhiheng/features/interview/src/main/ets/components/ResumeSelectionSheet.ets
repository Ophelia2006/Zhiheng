import { ResumeCardModel } from '@ohos/model/src/main/ets/Resume';
import { ResumeApi } from '@ohos/network';
import { hilog } from '@kit.PerformanceAnalysisKit';

@Component
export struct ResumeSelectionSheet {
  @Link isShow: boolean; // 用于控制半模态面板的显示与隐藏
  @Link selectedFormId: string; // 将选择的简历 ID 传递回父组件
  
  @State resumeList: ResumeCardModel[] = [];
  @State isLoading: boolean = true;
  @State errorMessage: string = '';
  
  // 确认回调函数，由父组件传入
  onConfirm?: () => void;

  async aboutToAppear() {
    await this.loadResumes();
  }

  async loadResumes() {
    this.isLoading = true;
    this.errorMessage = '';
    try {
      this.resumeList = await ResumeApi.getResumeList();
    } catch (error) {
      this.errorMessage = '获取简历列表失败';
      hilog.error(0, 'ResumeSelectionSheet', `获取简历列表失败: ${JSON.stringify(error)}`);
    } finally {
      this.isLoading = false;
    }
  }

  build() {
    Column() {
      // 顶部标题和关闭按钮
      Row() {
        Text('选择面试简历')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)


      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 10 })

      // 简历列表内容区
      if (this.isLoading) {
        Column() {
          LoadingProgress()
            .width(40)
            .height(40)
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else if (this.errorMessage) {
        Column() {
          Text(this.errorMessage)
            .fontSize(14)
            .fontColor(Color.Red)
            .margin({ bottom: 10 })
          Button('重试')
            .onClick(() => {
              this.loadResumes();
            })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else if (this.resumeList.length === 0) {
        Column() {
          Text('暂无简历，请先去添加一份吧')
            .fontSize(14)
            .fontColor('#999999')
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      } else {
        List({ space: 12 }) {
          ForEach(this.resumeList, (item: ResumeCardModel) => {
            ListItem() {
              Row() {
                Column() {
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#333333')
                    .margin({ bottom: 6 })
                  Text(item.date)
                    .fontSize(12)
                    .fontColor('#999999')
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)

                // 单选状态指示器
                Circle({ width: 20, height: 20 })
                  .fill(this.selectedFormId === item.id ? '#1EC18D' : 'transparent')
                  .stroke(this.selectedFormId === item.id ? '#1EC18D' : '#DDDDDD')
                  .strokeWidth(2)
              }
              .width('100%')
              .padding(16)
              .backgroundColor(this.selectedFormId === item.id ? '#F2FCF9' : '#F9F9F9')
              .borderRadius(12)
              .onClick(() => {
                this.selectedFormId = item.id;
              })
            }
          }, (item: ResumeCardModel) => item.id)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 20, right: 20 })
      }

      // 底部确认按钮
      Button('开始面试')
        .width('90%')
        .height(48)
        .backgroundColor(this.selectedFormId ? '#1EC18D' : '#DDDDDD')
        .fontColor(Color.White)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .margin({ top: 15, bottom: 20 })
        .enabled(!!this.selectedFormId)
        .onClick(() => {
          this.isShow = false;
          if (this.onConfirm) {
            this.onConfirm();
          }
        })
    }
    .width('100%')
    .height('100%') // 让内容填满 bindSheet 定义的区域，实现贴底效果
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
  }
}