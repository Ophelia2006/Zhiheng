import { InterviewQuestion } from '@ohos/model/src/main/ets/InterviewQuestion';
import { HttpUtil, HttpResponse } from '@ohos/network';
import { hilog } from '@kit.PerformanceAnalysisKit';

export class InterviewApi {
  /**
   * 启动面试，传入简历(表单)ID，从后端获取面试问题列表
   * @param formId 选择的简历ID
   * @returns 包含初始面试问题的数组
   */
  static async startInterview(formId: string): Promise<InterviewQuestion[]> {
    hilog.debug(0, 'InterviewApi', `开始获取面试问题，formId: ${formId}`);
    try {
      // TODO: 请将此 URL 替换为实际的后端获取面试问题接口地址
      const url = ':10010/api/agent/questions';

      // 组装 POST 请求的请求体，根据规范需显式声明为 Record<string, string> 或 Record<string, Object>
      const reqParam: Record<string, string> = {
        "formId": formId
      };

      // 发起 POST 请求
      // 后端返回的 data 是一个对象，里面包含 questions 数组
      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, reqParam);

      hilog.debug(0, 'InterviewApi', `获取面试问题原始响应: ${JSON.stringify(response)}`);

      const responseData = response.data;
      const questionList: InterviewQuestion[] = [];

      // 解析后端返回的数据并映射到前端模型
      if (responseData && responseData['questions']) {
        const questionsArray = responseData['questions'] as Record<string, Object>[];
        if (Array.isArray(questionsArray)) {
          for (let i = 0; i < questionsArray.length; i++) {
            const item = questionsArray[i];

            // 严格映射数据到 InterviewQuestion 接口，使用 Number/String 转换确保类型安全
            const question: InterviewQuestion = {
              num: Number(item['num']) || i + 1,
              level: Number(item['level']) || 0,
              questionDescription: String(item['questionDescription'] || '未知问题')
            };

            questionList.push(question);
          }
        }
      }

      hilog.debug(0, 'InterviewApi', `解析后的面试问题列表长度: ${questionList.length}`);
      return questionList;
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'InterviewApi', `获取面试问题失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 提交用户的回答并获取反馈/下一题（预留接口）
   * @param question 当前问题对象
   * @param answer 用户的回答文本
   * @returns 后端的评价或下一个问题
   */
  static async submitAnswer(question: InterviewQuestion, answer: string): Promise<Record<string, Object>> {
    try {
      // TODO: 替换为实际的提交回答接口地址
      const url = ':10010/api/agent/evaluations';

      // 根据后端接口定义，组装包含 questionWithAnswers 的请求体
      // 解决 ArkTS 严格模式报错：需要为对象字面量显式声明 Record 类型
      const questionRecord: Record<string, Object> = {
        "num": question.num,
        "level": question.level,
        "questionDescription": question.questionDescription
      };

      const answerItemRecord: Record<string, Object> = {
        "question": questionRecord,
        "answer": answer
      };

      const reqParam: Record<string, Object> = {
        "questionWithAnswers": [answerItemRecord]
      };

      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, reqParam);
      hilog.debug(0, 'InterviewApi', `submitAnswer 原始响应数据 ${JSON.stringify(response)}`)

      // API 返回的数据在 response.data 中。
      // 根据报错日志，后端返回的 response.data 是一个数组 (Array)，而不是直接的对象。
      // 日志提示: Cannot deserialize value of type `ApiEvaluationResp` from Array value
      // 所以我们需要提取出数组中的第一个元素作为 apiResp
      const responseData = response.data;
      let apiRespObj: Record<string, Object> = {};

      if (Array.isArray(responseData) && responseData.length > 0) {
        // 使用类型转换来解决 arkts-no-props-by-index 报错
        const dataArray = responseData as Record<string, Object>[];
        // dataArray[0] 是类似 { "question": {...}, "answer": "...", "apiResp": { "comment": "..." } } 的结构
        // 但我们这里只需要它的 apiResp 字段，而不是把它整体当作 apiRespObj
        const firstItem = dataArray[0];
        if (firstItem && firstItem['apiResp']) {
          apiRespObj = firstItem['apiResp'] as Record<string, Object>;
        } else {
          apiRespObj = firstItem; // fallback
        }
      } else if (responseData && !Array.isArray(responseData)) {
        // 如果后端直接返回的是包含了 apiResp 的对象
        if (responseData['apiResp']) {
          apiRespObj = responseData['apiResp'] as Record<string, Object>;
        } else {
          apiRespObj = responseData as Record<string, Object>;
        }
      }

      const answerEvaluationResp: Record<string, Object> = {
        "question": questionRecord,
        "answer": answer,
        "apiResp": apiRespObj
      };

      return answerEvaluationResp;
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'InterviewApi', `提交回答失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }

  /**
   * 生成面试报告（在所有问题回答完毕后调用）
   * @param formId 面试使用的简历 ID
   * @param evaluations 包含所有问答对及评估结果的数组
   * @returns 生成的报告 ID 或状态
   */
  static async generateReport(formId: string, evaluations: Record<string, Object>[]): Promise<Record<string, Object>> {
    try {
      // TODO: 替换为实际的生成报告接口地址
      const url = ':10010/api/agent/report';

      // const reqParam: Record<string, Object> = {
      //   "answerEvaluationRespS": evaluations,
      //   "formId": formId
      // };

      const reqParam: Record<string, Object> = {
        "answerEvaluationRespS": evaluations,
        "formId": formId
      };
      hilog.debug(0, 'InterviewApi', `reqParam内容 ${JSON.stringify(reqParam)}`)
      const response = await HttpUtil.post<HttpResponse<Record<string, Object>>>(url, reqParam);
      hilog.debug(0, 'InterviewApi', `generateReport 原始响应数据 ${JSON.stringify(response)}`)
      return response.data || {};
    } catch (err) {
      const error: Error = err;
      hilog.error(0, 'InterviewApi', `生成面试报告失败: ${JSON.stringify(error)}`);
      throw error;
    }
  }
}
