import {
  InterviewReport,
  ReportCardModel,
  RadarData,
  QnAItem
} from '@ohos/model/src/main/ets/InterviewReport';
import { HttpUtil, HttpResponse } from '@ohos/network'
import { hilog } from '@kit.PerformanceAnalysisKit';

export class ReportApi {
  // /**
  //  * 获取面试报告列表
  //  * 模拟从后端获取用户的全部面试记录报告
  //  */
  // static async getReportList(): Promise<InterviewReport[]> {
  //   return new Promise((resolve) => {
  //   });
  // }

  /**
   * 获取面试报告列表
   * 从后端获取用户的全部面试记录报告
   */
  static async getReportList(): Promise<ReportCardModel[]> {
    hilog.debug(0, 'ReportApi', `getReportList中`)
    try {
      const url = ':10010/record/service/search/record';

      // 发起 GET 请求
      // 注意：这里使用 HttpResponse 包裹一层，告诉编译器我们期望的 data 是一个对象数组
      const response = await HttpUtil.get<HttpResponse<Record<string, Object>[]>>(url);
      hilog.debug(0, 'ReportApi', `面试报告列表原始响应: ${JSON.stringify(response)}`)

      // 从外层响应中提取出真正的 data 数组
      const listData = response.data;

      // 解构 response，将后端字段映射为前端 InterviewReport 接口需要的结构
      const reportList: ReportCardModel[] = [];

      // 针对提取出来的 listData 进行长度判断和循环
      if (listData && listData.length > 0) {
        for (let i = 0; i < listData.length; i++) {
          const item = listData[i];

          // 解析日期
          let monthStr = 'Mon';
          let dayStr = '00';
          if (item.createTime) {
            // 将 Java 的日期字符串转为 Date 对象
            const date = new Date(String(item.createTime));
            if (!isNaN(date.getTime())) {
              // 获取月份简写 (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec)
              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
              monthStr = months[date.getMonth()];

              // 获取日期，不足两位补0
              const day = date.getDate();
              dayStr = day < 10 ? `0${day}` : `${day}`;
            }
          }

          // 严格一项一项赋值，避免使用 as 强转带来的类型不安全
          const reportItem: ReportCardModel = {
            id: item.id ? String(item.id) : '',
            title: item.name ? String(item.name) : '未命名面试',
            month: monthStr,
            day: dayStr,
            score: item.interviewPoint !== undefined && item.interviewPoint !== null ? `${item.interviewPoint}分` :
              `0分`
          };
          hilog.debug(0, 'ReportApi', `赋值后数据 ${JSON.stringify(reportItem)}`)
          reportList.push(reportItem);
        }
      }

      return reportList;
    } catch (err) {
      const error: Error = err
      hilog.error(0, 'ReportApi', `获取面试报告列表失败 ${error}`);
      // 如果请求失败，抛出错误，交由上层（如 ViewModel）处理
      throw error;
    }
  }


  /**
   * 获取单个面试报告的详细信息
   * 根据 ReportDetailComponent 的 UI 结构填充完整的 Mock 数据
   * @param reportId 报告ID
   */
  static async getReportDetail(reportId: string): Promise<InterviewReport> {
    try {
      // 假设这是通过 GET 请求获取详情，reportId 拼接到 URL 后面
      const url = `:10010/record/service/click/record`;

      hilog.debug(0, 'ReportApi', `获取的reportId :${reportId}`)

      // 发起 POST 请求
      // 组装请求参数，必须显式声明类型
      const reqParam: Record<string, string> = {
        "id": reportId
      };

      // 注意：详情接口返回的 data 是一个对象 (Record<string, Object>)，而不是数组
      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, reqParam);
      hilog.debug(0, 'ReportApi', `面试详情报告原始响应: ${JSON.stringify(response)}`)

      // 从外层响应中提取出真正的 data 对象
      const data = response.data;

      if (!data) {
        throw new Error('未获取到报告数据');
      }

      // 计算雷达图的五项分数
      const accuracyScore = Number(data['accuracyScore']) || 0;
      const completenessScore = Number(data['completenessScore']) || 0;
      const levelOfDetailScore = Number(data['levelOfDetailScore']) || 0;
      const logicScore = Number(data['logicScore']) || 0;
      const expressionAbilityScore = Number(data['expressionAbilityScore']) || 0;

      // 直接读取后端返回的总分
      const totalScore = Number(data['interviewPoint']) || 0;

      // 根据总分简单评定等级（可根据实际业务修改）
      let grade = '及格';
      if (totalScore >= 90) {
        grade = '优秀';
      } else if (totalScore >= 80) {
        grade = '良好';
      } else if (totalScore < 60) {
        grade =
          '待提升';
      }

      // 解析知识点标签 (JSON 字符串数组)
      let knowledgeTags: string[] = [];
      if (data['interviewKeywords']) {
        try {
          const parsedTags = JSON.parse(String(data['interviewKeywords'] )) as string[];
          if (Array.isArray(parsedTags)) {
            for (let i = 0; i < parsedTags.length; i++) {
              knowledgeTags.push(String(parsedTags[i]));
            }
          }
        } catch (e) {
          hilog.error(0, 'ReportApi', `解析 knowledgeTags 失败: ${e}`);
        }
      }

      // 严格映射数据到 InterviewReport 接口
      const reportDetail: InterviewReport = {
        id: data['id'] ? String(data['id']) : reportId,
        title: data['recordName'] ? String(data['recordName']) : '面试报告详情',
        totalScore: totalScore,
        grade: grade,

        radarData: {
          accuracyScore: accuracyScore,
          completenessScore: completenessScore,
          levelOfDetailScore: levelOfDetailScore,
          logicScore: logicScore,
          expressionAbilityScore: expressionAbilityScore
        },

        knowledgeTags: knowledgeTags,
        summary: data['summaryReportRecord'] ? String(data['summaryReportRecord']).replace(/^"|"$/g, '') :
          '暂无总结报告',
        suggestions: data['adviceReportRecord'] ? String(data['adviceReportRecord']).replace(/^"|"$/g, '') : '暂无建议',

        // 面试过程记录通常是一个 JSON 字符串，包含问答对，如果后端是存成字符串的，需要尝试解析
        qnaList: []
      };

      // 如果后端传来了 JSON 格式的面试过程记录，尝试将其解析并推入 qnaList
      if (data['interviewProcessRecord']) {
        try {
          const parsedQnA = JSON.parse(String(data['interviewProcessRecord'])) as Record<string, Object>[];
          if (Array.isArray(parsedQnA)) {
            for (let i = 0; i < parsedQnA.length; i++) {
              const item = parsedQnA[i];

              // 安全提取嵌套对象
              const questionObj = (item['question'] as Record<string, Object>) || {};
              const apiRespObj = (item['apiResp'] as Record<string, Object>) || {};

              // 计算该题的综合得分（取平均值或自定义逻辑，这里做个简单示例）
              let singleScore = 0;
              if (apiRespObj) {
                const sum = (Number(apiRespObj['logic']) || 0) +
                  (Number(apiRespObj['accuracy']) || 0) +
                  (Number(apiRespObj['completeness']) || 0) +
                  (Number(apiRespObj['levelOfDetail']) || 0) +
                  (Number(apiRespObj['expressionAbility']) || 0);
                singleScore = Math.round(sum / 5);
              }

              reportDetail.qnaList.push({
                question: questionObj['questionDescription'] ? String(questionObj['questionDescription']) : '未知问题',
                answer: item['answer'] ? String(item['answer']) : '暂无回答',
                evaluation: apiRespObj['comment'] ? String(apiRespObj['comment']) : '暂无评价',
                score: singleScore
              });
            }
          }
        } catch (e) {
          hilog.error(0, 'ReportApi', `解析问答记录失败: ${e}`);
        }
      }

      return reportDetail;
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'ReportApi', `获取面试报告详情失败 ${error}`);
      // 如果请求失败，抛出错误，交由上层（如 ViewModel）处理
      throw error;
    }
  }
}