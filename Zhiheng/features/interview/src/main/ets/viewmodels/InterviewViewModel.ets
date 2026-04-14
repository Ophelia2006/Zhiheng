import { Message, MessageType } from '../model/Message';
import { InterviewApi } from '../api/InterviewApi';
import { InterviewQuestion } from '@ohos/model/src/main/ets/InterviewQuestion';
import { hilog } from '@kit.PerformanceAnalysisKit';

export enum InterviewStatus {
  PREPARING = 0, // 待开始（已进入页面，AI发了欢迎语，等用户点开始）
  IN_PROGRESS = 1, // 面试中
  FINISHED = 2, // 已结束（报告生成成功或正在生成中）
  REPORT_FAILED = 3 // 报告生成失败，等待重试
}

@Observed
export class InterviewViewModel {
  messages: Message[] = [];
  questions: InterviewQuestion[] = [];
  currentQuestionIndex: number = 0;
  isLoading: boolean = false;
  status: InterviewStatus = InterviewStatus.PREPARING; // 记录当前面试状态
  formId: string = ''; // 暂存传入的简历ID
  evaluations: Record<string, Object>[] = []; // 暂存每次回答的后端评估结果，用于最终生成报告

  constructor() {
    // 初始状态下不加载任何消息，等待 startInterview 调用
  }

  /**
   * 初始化面试，仅发送欢迎语，等待用户点击“开始面试”
   * @param formId 简历ID
   */
  initInterview(formId: string) {
    if (!formId) {
      hilog.error(0, 'InterviewViewModel', 'formId 为空，无法初始化面试');
      return;
    }
    this.formId = formId;
    this.status = InterviewStatus.PREPARING;
    this.messages = [this.createAIMessage("你好！我已经阅读了你的简历，接下来我们将进行一场模拟面试。准备好了吗？")];
  }

  /**
   * 辅助方法：模拟延迟
   */
  private async delay(ms: number) {
    return new Promise<void>(resolve => setTimeout(resolve, ms));
  }

  /**
   * 启动面试，获取问题列表并展示第一题
   */
  async startInterview() {
    if (!this.formId) {
      hilog.error(0, 'InterviewViewModel', 'formId 为空，无法启动面试');
      return;
    }

    this.isLoading = true;
    try {
      // 1. 获取面试问题
      const questionList = await InterviewApi.startInterview(this.formId);
      this.questions = questionList;
      this.currentQuestionIndex = 0;

      // 2. 变更状态为面试中
      this.status = InterviewStatus.IN_PROGRESS;

      // 3. 将用户的“开始面试”指令作为一条消息上屏（可选，显得更真实）
      this.messages = [...this.messages, this.createUserMessage("开始面试")];

      // 增加 1 秒延迟，模拟 AI 思考和对话感
      await this.delay(1000);

      // 4. 发送第一题（如果有的话）
      if (this.questions.length > 0) {
        const currentQ = this.questions[this.currentQuestionIndex];
        const questionMsg = this.createAIMessage(`问题 ${currentQ.num}: ${currentQ.questionDescription}`);
        this.messages = [...this.messages, questionMsg];
      } else {
        this.messages = [...this.messages, this.createAIMessage("暂时没有获取到面试问题，请稍后再试。")];
      }

    } catch (err) {
      const error = err as Error
      hilog.error(0, 'InterviewViewModel', `启动面试失败: ${error}`);
      this.messages = [...this.messages, this.createAIMessage("获取面试数据失败，请检查网络或重试。")];
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 用户发送回答
   * @param content 用户回答文本
   */
  async sendUserAnswer(content: string) {
    if (!content.trim()) {
      return;
    }

    // 1. 将用户的回答加入对话列表
    const userMsg = this.createUserMessage(content);2
    // 重新赋值触发更新
    this.messages = [...this.messages, userMsg];

    // 如果已经没有问题了，直接返回
    if (this.currentQuestionIndex >= this.questions.length) {
      const endMsg = this.createAIMessage("面试已经结束，感谢你的参与！稍后可以查看面试报告。");
      this.messages = [...this.messages, endMsg];
      return;
    }

    this.isLoading = true;
    try {
      const currentQ = this.questions[this.currentQuestionIndex];

      // 2. 提交回答到后端并获取评估结果
      const evaluationResp = await InterviewApi.submitAnswer(currentQ, content);
      
      // 记录此次问答和评估结果，为最后生成报告准备
      this.evaluations.push(evaluationResp);

      // 3. 推进到下一题
      this.currentQuestionIndex++;

      // 增加 1 秒延迟，模拟 AI 思考和对话感
      await this.delay(1000);

      if (this.currentQuestionIndex < this.questions.length) {
        // 继续问下一题
        const nextQ = this.questions[this.currentQuestionIndex];
        const nextMsg = this.createAIMessage(`问题 ${nextQ.num}: ${nextQ.questionDescription}`);
        this.messages = [...this.messages, nextMsg];
      } else {
        // 面试结束，发起生成报告请求
        this.status = InterviewStatus.FINISHED;
        const endMsg = this.createAIMessage("以上就是所有的面试问题。面试结束，感谢你的参与！系统正在为你生成面试报告...");
        this.messages = [...this.messages, endMsg];
        
        // 异步调用生成报告接口，不阻塞 UI 状态更新
        this.generateInterviewReport();
      }

    } catch (error) {
      hilog.error(0, 'InterviewViewModel', `提交回答失败: ${error}`);
      const errorMsg = this.createAIMessage("抱歉，网络出现问题，未能成功提交你的回答，请重试。");
      this.messages = [...this.messages, errorMsg];
    } finally {
      this.isLoading = false;
    }
  }

  /**
   * 内部方法：调用 API 生成面试报告
   */
  public async generateInterviewReport() {
    this.isLoading = true;
    try {
      hilog.info(0, 'InterviewViewModel', '开始生成面试报告...');
      const reportResult = await InterviewApi.generateReport(this.formId, this.evaluations);
      hilog.info(0, 'InterviewViewModel', `面试报告生成成功: ${JSON.stringify(reportResult)}`);
      
      this.status = InterviewStatus.FINISHED;
      // 报告生成成功后，可以在聊天框中添加一个查看报告的提示
      const reportReadyMsg = this.createAIMessage("你的面试报告已生成成功，可以前往报告列表查看详细评价！");
      this.messages = [...this.messages, reportReadyMsg];
    } catch (error) {
      hilog.error(0, 'InterviewViewModel', `生成面试报告失败: ${error}`);
      this.status = InterviewStatus.REPORT_FAILED;
      const errorMsg = this.createAIMessage("抱歉，生成面试报告时出现网络错误，请点击底部按钮重试。");
      this.messages = [...this.messages, errorMsg];
    } finally {
      this.isLoading = false;
    }
  }

  // Returns the new message to be added to the state in UI
  createUserMessage(content: string): Message {
    return new Message(Date.now().toString(), content, true, MessageType.TEXT);
  }

  createAIMessage(content: string): Message {
    return new Message((Date.now() + 1).toString(), content, false, MessageType.TEXT);
  }
}
