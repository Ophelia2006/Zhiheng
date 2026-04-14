import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { ReportCardModel } from '@ohos/model/src/main/ets/InterviewReport';
import { GenericBasicDataSource } from '@ohos/model/src/main/ets/utils/GenericBasicDataSource';
import { ReportCard } from '../components/ReportCard';
import { ReportApi } from '../api/ReportApi'
import { hilog } from '@kit.PerformanceAnalysisKit';

class ReportDataSource extends GenericBasicDataSource<ReportCardModel> {
}

@Component
export struct ReportPage {
  @State isRefreshing: boolean = false;
  private reportData: ReportDataSource = new ReportDataSource();
  reportList: ReportCardModel[] = []

  async loadData() {
    try {
      this.reportList = await ReportApi.getReportList()
      hilog.debug(0, 'ReportPage', `${JSON.stringify(this.reportList)}`)
      this.reportData.setDataArray(this.reportList);
      hilog.debug(0, 'ReportPage', `reportData内容 ${JSON.stringify(this.reportData)}`)
    } catch (error) {
      hilog.error(0, 'ReportPage', `获取数据失败: ${error}`);
    }
  }

  async aboutToAppear(): Promise<void> {
    await this.loadData();
  }

  build() {
    Column() {
      Row() {
        Text('面试记录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1A1A')
          .letterSpacing(1)
      }
      .width('100%')
      .padding({ left: 25, top: 20, bottom: 10 })
      .backgroundColor('#FFFFFF')

      // List Content 使用组件复用
      Refresh({ refreshing: $$this.isRefreshing }) {
        List({ space: 15 }) {
          LazyForEach(this.reportData, (item: ReportCardModel) => {
            ListItem() {
              ReportCard({
                month: item.month,
                day: item.day,
                title: item.title,
                score: item.score
              })
                .reuseId('report')
            }
            .onClick(() => {
              // 跳转到报告详情页，并传递报告的 ID
              // ArkTS 严格模式下，直接传递字面量即使 as 也会报错，应该先声明 Record 变量
              let params: Record<string, Object> = {
                "id": item.id
              };
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.REPORT_DETAIL, params);
            })
          },
            (item: ReportCardModel) => item.id.toString())
        }
        .cachedCount(2)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 25, right: 25 })
      }
      .onRefreshing(async () => {
        // 触发下拉刷新时，重新请求数据
        await this.loadData();
        // 数据请求完成后，关闭刷新状态，动画收起
        this.isRefreshing = false;
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
