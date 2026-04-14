import { InterviewReport,ReportCardModel } from '@ohos/model/src/main/ets/InterviewReport';
import { ReportApi } from '../api/ReportApi';

/**
 * 报告列表页面的 ViewModel
 * 负责从 API 获取数据，维护列表状态
 */
@Observed
export class ReportListViewModel {
  // 核心数据：报告列表
  public reportList: ReportCardModel[] = [];
  
  // 页面状态
  public isLoading: boolean = true;
  public errorMsg: string = '';

  /**
   * 获取报告列表数据
   * 目前 API 设计为不分页，一次性获取全部
   */
  async fetchReportList() {
    this.isLoading = true;
    this.errorMsg = '';
    
    try {
      // 调用 API 层获取数据
      const data = await ReportApi.getReportList();
      this.reportList = data;
    } catch (error) {
      this.errorMsg = '获取报告列表失败，请稍后重试';
      console.error('ReportListViewModel fetch error:', error);
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 下拉刷新数据
   */
  async refreshData() {
    // 刷新时可以不显示全屏的 isLoading，而是依赖 UI 层的 Refresh 组件动画
    try {
      const data = await ReportApi.getReportList();
      this.reportList = data;
      this.errorMsg = '';
    } catch (error) {
      this.errorMsg = '刷新失败';
      console.error('ReportListViewModel refresh error:', error);
    }
  }
}