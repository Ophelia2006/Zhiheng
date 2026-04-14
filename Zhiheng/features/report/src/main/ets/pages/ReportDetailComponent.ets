import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { LengthMetrics } from '@kit.ArkUI';
import { ReportDetailViewModel } from '../viewmodels/ReportDetailViewModel';
import { InterviewReport, RadarData, QnAItem } from '@ohos/model/src/main/ets/InterviewReport';
import { RadarChartComponent } from '../components/RadarChartComponent';

@Component
export struct ReportDetailComponent {
  // 注入 ViewModel
  @State viewModel: ReportDetailViewModel = new ReportDetailViewModel();
  // 接收路由参数
  @Prop routerParams: Record<string, string>;

  aboutToAppear() {
    // 从路由参数中获取真正的 reportId，如果没有则使用默认的 mock_report_id_123
    const reportId = (this.routerParams && this.routerParams['id']) ? this.routerParams['id'] : '0000000000000';
    hilog.info(0x0000, 'ReportDetail', `Fetching detail for report ID: ${reportId}`);
    this.viewModel.fetchReportDetail(reportId);
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        if (this.viewModel.isLoading) {
          Column() {
            // 加载中状态
            LoadingProgress()
              .width(60)
              .height(60)
              .margin({ top: 100 })
          }
          .width('100%')
          .height('100%')
        } else if (this.viewModel.errorMsg) {
          Column() {
            // 错误状态
            Text(this.viewModel.errorMsg)
              .fontSize(16)
              .fontColor(Color.Red)
              .margin({ top: 100 })
          }
          .width('100%')
          .height('100%')
        } else if (this.viewModel.reportDetail) {
          // 1. 顶部：面试总分 + 等级评价
          this.ScoreHeaderBuilder(this.viewModel.reportDetail)

          // 2. 五维雷达图：使用第三方库 mpchart 绘制
          Column() {
            Text('能力雷达图')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .textAlign(TextAlign.Start)
            // .margin({ bottom: 15 })

            RadarChartComponent({ radarData: this.viewModel.reportDetail.radarData })
              .hitTestBehavior(HitTestMode.BLOCK_HIERARCHY)
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#FFFFFF')
          .borderRadius(30)
          .shadow({
            radius: 10,
            color: '#0A000000',
            offsetX: 0,
            offsetY: 4
          })

          // 3. 知识点：标签式展示
          this.KnowledgeTagsBuilder(this.viewModel.reportDetail.knowledgeTags)

          // 4. 总结报告：详细分析段落
          this.SummaryReportBuilder(this.viewModel.reportDetail.summary)

          // 5. 建议：可操作的改进指南
          this.SuggestionsBuilder(this.viewModel.reportDetail.suggestions)

          // 6. 10道问答：可展开折叠的卡片
          this.QnAListBuilder(this.viewModel.reportDetail.qnaList)
        }
      }
      .width('100%')
      .padding({
        left: 20,
        right: 20,
        top: 20,
        bottom: 40
      })
      .backgroundColor('#F5F7FA') // 浅灰背景，突出白色卡片
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  // --- 1. 顶部：面试总分 + 等级评价 ---
  @Builder
  ScoreHeaderBuilder(report: InterviewReport) {
    Column() {
      Text(`综合评价: ${report.grade}`)
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1EC18D')
        .margin({ bottom: 10 })

      Row({ space: 10 }) {
        Text(`${report.totalScore}`)
          .fontSize(48)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#333333')
        Text('分')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ bottom: 8 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .alignItems(HorizontalAlign.Center)
    .shadow({
      radius: 10,
      color: '#0A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  // --- 3. 知识点：标签式展示 ---
  @Builder
  KnowledgeTagsBuilder(tags: string[]) {
    Column() {
      Text('核心知识点')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 15 })

      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
        ForEach(tags, (tag: string) => {
          // 由于后端现在只返回字符串数组，我们使用统一的样式即可
          this.TagBuilder(tag, '#E6F9F0', '#1EC18D')
        }, (tag: string) => tag)
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({
      radius: 10,
      color: '#0A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  @Builder
  TagBuilder(text: string, bgColor: string, textColor: string) {
    Text(text)
      .fontSize(13)
      .fontColor(textColor)
      .backgroundColor(bgColor)
      .padding({
        left: 12,
        right: 12,
        top: 6,
        bottom: 6
      })
      .borderRadius(16)
  }

  // --- 4. 总结报告：详细分析段落 ---
  @Builder
  SummaryReportBuilder(summary: string) {
    Column() {
      Text('面试总结')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10 })

      Text(summary)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(22)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({
      radius: 10,
      color: '#0A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  // --- 5. 建议：可操作的改进指南 ---
  @Builder
  SuggestionsBuilder(suggestions: string) {
    Column() {
      Text('改进建议')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10 })

      Text(suggestions)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(22)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({
      radius: 10,
      color: '#0A000000',
      offsetX: 0,
      offsetY: 4
    })
  }

  // --- 6. 10道问答：可展开折叠的卡片 ---
  @Builder
  QnAListBuilder(qnaList: QnAItem[]) {
    Column() {
      Text('面试问答回顾')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 15 })

      List({ space: 10 }) {
        ForEach(qnaList, (item: QnAItem, index: number) => {
          ListItem() {
            Column() {
              // 问题区域 (可点击)
              Row() {
                Text(`Q${index + 1}: ${item.question}`)
                  .fontSize(15)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#333333')
                  .layoutWeight(1)

                Text(this.viewModel.expandedStates[index] ? '▲' : '▼')
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ left: 10 })
              }
              .width('100%')
              .padding(15)
              .backgroundColor('#F9F9F9')
              .borderRadius(this.viewModel.expandedStates[index] ? { topLeft: 8, topRight: 8 } : 8)
              .onClick(() => {
                this.viewModel.toggleQnA(index);
              })

              // 回答区域 (展开时显示)
              if (this.viewModel.expandedStates[index]) {
                Column({ space: 10 }) {
                  Text(item.answer)
                    .fontSize(14)
                    .fontColor(Color.Black)
                    .lineHeight(20)
                    .width('100%')
                    .textAlign(TextAlign.Start)

                  Text(item.evaluation)
                    .fontSize(14)
                    .fontColor('#1EC18D') // Green color for evaluation
                    .lineHeight(20)
                    .width('100%')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')
                .padding(15)
                .backgroundColor('#FFFFFF')
                .border({ width: { bottom: 1, left: 1, right: 1 }, color: '#F0F0F0' })
                .borderRadius({ bottomLeft: 8, bottomRight: 8 })
              }
            }
            .width('100%')
            // 添加展开动画
            .animation({ duration: 300, curve: Curve.EaseInOut })
          }
        }, (item: QnAItem, index: number) => index.toString())
      }
      .width('100%')
      .height(450) // 限制高度，使内部列表可滚动
      .scrollBar(BarState.Auto)
      .nestedScroll({ scrollForward: NestedScrollMode.SELF_FIRST, scrollBackward: NestedScrollMode.SELF_FIRST })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({
      radius: 10,
      color: '#0A000000',
      offsetX: 0,
      offsetY: 4
    })
  }
}
