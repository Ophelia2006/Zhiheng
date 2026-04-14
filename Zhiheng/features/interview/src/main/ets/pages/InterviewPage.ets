import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { HttpUtil, HttpResponse } from '@ohos/network'
import { ResumeSelectionSheet } from '../components/ResumeSelectionSheet';

@Component
export struct InterviewPage {
  // 控制半模态弹窗显隐
  @State isShowSheet: boolean = false;
  // 选中的简历 ID
  @State selectedFormId: string = '';

  // 动画状态
  @State waveScale1: number = 1;
  @State waveOpacity1: number = 0.6;
  @State waveScale2: number = 1;
  @State waveOpacity2: number = 0.6;
  @State waveScale3: number = 1;
  @State waveOpacity3: number = 0.6;
  @State coreScale: number = 1;
  @State rotateAngle: number = 0;

  aboutToAppear() {
    // 启动波纹动画
    setTimeout(() => {
      this.waveScale1 = 3.5;
      this.waveOpacity1 = 0;
    }, 50);

    setTimeout(() => {
      this.waveScale2 = 3.5;
      this.waveOpacity2 = 0;
    }, 1000);

    setTimeout(() => {
      this.waveScale3 = 3.5;
      this.waveOpacity3 = 0;
    }, 2000);

    // 核心呼吸动画
    setTimeout(() => {
      this.coreScale = 1.15;
      this.rotateAngle = 360;
    }, 50);
  }

  // 自定义半模态弹窗的内容构建器
  @Builder
  SheetBuilder() {
    ResumeSelectionSheet({
      isShow: this.isShowSheet,
      selectedFormId: this.selectedFormId,
      onConfirm: () => {
        // 关闭弹窗
        this.isShowSheet = false;
        // 当用户在弹窗中点击“开始面试”时触发
        this.startInterview();
      }
    })
  }

  // 开始面试的逻辑
  async startInterview() {
    if (!this.selectedFormId) {
      hilog.warn(0, 'InterviewPage', '未选择简历，无法开始面试');
      return;
    }

    // 通过路由将选中的 formId 传递给 DialogComponent
    const params: Record<string, Object> = { 'formId': this.selectedFormId };
    buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.INTERVIEW_DIALOG, params);
    hilog.debug(0, 'InterviewPage', `路由跳转到 INTERVIEW_DIALOG，携带 formId: ${this.selectedFormId}`);
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // AI 面试官高级动画层 (放在底层，避开底部卡片)
      Column() {
        Stack({ alignContent: Alignment.Center }) {
          // 波纹3
          Circle({ width: 100, height: 100 })
            .fill($r('app.color.green_botton'))
            .opacity(this.waveOpacity3)
            .scale({ x: this.waveScale3, y: this.waveScale3 })
            .animation({ duration: 3000, iterations: -1, curve: Curve.FastOutSlowIn })

          // 波纹2
          Circle({ width: 100, height: 100 })
            .fill($r('app.color.green_botton'))
            .opacity(this.waveOpacity2)
            .scale({ x: this.waveScale2, y: this.waveScale2 })
            .animation({ duration: 3000, iterations: -1, curve: Curve.FastOutSlowIn })

          // 波纹1
          Circle({ width: 100, height: 100 })
            .fill($r('app.color.green_botton'))
            .opacity(this.waveOpacity1)
            .scale({ x: this.waveScale1, y: this.waveScale1 })
            .animation({ duration: 3000, iterations: -1, curve: Curve.FastOutSlowIn })

          // 科技感旋转外环 (虚线)
          Circle({ width: 140, height: 140 })
            .fill(Color.Transparent)
            .border({ width: 2, color: $r('app.color.green_botton'), style: BorderStyle.Dashed })
            .opacity(0.3)
            .rotate({ angle: this.rotateAngle })
            .animation({ duration: 8000, iterations: -1, curve: Curve.Linear })

          // 内层反向旋转装饰环
          Circle({ width: 120, height: 120 })
            .fill(Color.Transparent)
            .border({ width: 1, color: $r('app.color.green_botton'), style: BorderStyle.Dashed })
            .opacity(0.5)
            .rotate({ angle: -this.rotateAngle })
            .animation({ duration: 6000, iterations: -1, curve: Curve.Linear })

          // 中心核心 AI 头像 / 光球
          Stack({ alignContent: Alignment.Center }) {
            Circle({ width: 90, height: 90 })
              .fill($r('app.color.green_botton'))
              .shadow({ radius: 20, color: $r('app.color.green_botton'), offsetX: 0, offsetY: 0 })
            
            Image($r('app.media.zhiheng_avatar')) 
              .width(70)
              .height(70)
              .borderRadius(35)
          }
          .scale({ x: this.coreScale, y: this.coreScale })
          .animation({ duration: 1500, iterations: -1, curve: Curve.EaseInOut, playMode: PlayMode.Alternate })
        }
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ bottom: 200 }) // 向上偏移，避开底部卡片

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
              // 点击“去面试”按钮时，拉起半模态弹窗，而不是直接发请求或跳转
              this.isShowSheet = true;
            })
            // 绑定半模态弹窗
            .bindSheet($$this.isShowSheet, this.SheetBuilder(), {
              height: SheetSize.MEDIUM, // 占据一半高度
              dragBar: true,            // 允许拖拽
              backgroundColor: Color.Transparent, // 背景透明，由 Sheet 内容控制
              showClose: false,          // 隐藏默认的关闭按钮，我们自己画了
              onDisappear: () => {
                this.isShowSheet = false;
              }
            })
          }
          .width('100%')
        }
        .width('95%')
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
