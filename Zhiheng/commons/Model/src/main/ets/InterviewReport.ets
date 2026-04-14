export interface InterviewReport {
  id: string;               // 报告唯一标识
  title: string;            // 报告标题 (对应后端 recordName)
  
  // 总体评价
  totalScore: number;       // 总分 (对应后端 interviewPoint)
  grade: string;            // 评级 (前端计算或保留)
  
  // 五维雷达图数据
  radarData: RadarData;
  
  // 知识点标签 (对应后端 interviewKeywords 解析后的字符串数组)
  knowledgeTags: string[]; 
  
  // 总结与建议
  summary: string;          // 面试总结段落 (对应后端 summaryReportRecord)
  suggestions: string;      // 改进建议 (对应后端 adviceReportRecord)
  
  // 问答回顾列表
  qnaList: QnAItem[];
}

export interface RadarData {
  accuracyScore: number;         // 准确性得分
  completenessScore: number;     // 完整性得分
  levelOfDetailScore: number;    // 详细程度得分
  logicScore: number;            // 逻辑得分
  expressionAbilityScore: number;// 表达能力得分
}

export interface QnAItem {
  question: string;         // 面试问题
  answer: string;           // 候选人回答
  evaluation: string;       // AI 评价
  score: number;            // 该题综合得分(可选)
}

/**
 * 面试记录列表卡片的数据模型 (轻量级)
 */
export interface ReportCardModel {
  id: string;      // 报告的唯一标识 (用于点击跳转和 ForEach 的 key)
  month: string;   // 月份，如 'Mar'
  day: string;     // 日期，如 '22'
  title: string;   // 面试标题，如 'Java后端模拟面试'
  score: string;   // 分数展示，如 '85分'
}
