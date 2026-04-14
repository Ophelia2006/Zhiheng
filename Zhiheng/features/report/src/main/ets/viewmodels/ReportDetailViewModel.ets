import { InterviewReport } from '@ohos/model/src/main/ets/InterviewReport';
import { ReportApi } from '../api/ReportApi';

/**
 * 报告详情页面的 ViewModel
 * 负责从 API 获取数据，并维护页面 UI 的状态（如加载中、展开折叠状态）
 */
@Observed
export class ReportDetailViewModel {
  // 核心数据模型
  public reportDetail: InterviewReport | null = null;
  
  // 页面状态
  public isLoading: boolean = true;
  public errorMsg: string = '';
  
  // UI 交互状态：记录问答列表中每一项的展开/折叠状态
  public expandedStates: boolean[] = [];

  /**
   * 根据报告 ID 获取详情数据
   * @param reportId 报告唯一标识
   */
  async fetchReportDetail(reportId: string) {
    this.isLoading = true;
    this.errorMsg = '';
    
    try {
      // 模拟调用 API 层获取数据
      this.reportDetail = await ReportApi.getReportDetail(reportId);
      
      // 数据加载成功后，根据 qnaList 的长度初始化展开状态数组，默认全部折叠 (false)
      if (this.reportDetail && this.reportDetail.qnaList) {
        this.expandedStates = new Array(this.reportDetail.qnaList.length).fill(false);
      }
    } catch (error) {
      this.errorMsg = '获取报告详情失败，请稍后重试';
      console.error('ReportDetailViewModel fetch error:', error);
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 切换指定问答项的展开/折叠状态
   * @param index 问答项在列表中的索引
   */
  toggleQnA(index: number) {
    if (index >= 0 && index < this.expandedStates.length) {
      // 数组元素的修改在 ArkTS 中直接修改索引可能无法触发 UI 刷新，
      // 推荐的做法是创建一个新数组或使用特定方法（如果在组件内部直接用 @State 数组修改某项是可以的，
      // 但在 @Observed 类中，通常需要改变数组的引用或使用 splice）
      const newStates = [...this.expandedStates];
      newStates[index] = !newStates[index];
      this.expandedStates = newStates;
    }
  }
}