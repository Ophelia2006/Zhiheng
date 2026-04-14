/**
 * 面试问题的数据模型
 */
export interface InterviewQuestion {
  num: number;               // 问题编号 (如: 1, 2, 3)
  level: number;             // 面试问题等级 (如: 0-基础, 1-进阶, 2-深入)
  questionDescription: string; // 面试问题具体内容
}
