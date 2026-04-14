/**
 * 简历核心数据结构
 * 涵盖了标准简历所需的所有字段，并为未来的 OCR 识别图片预留了字段。
 */
export interface Resume {
  id: string;               // 简历唯一标识 (UUID)
  userId: string;           // 归属用户 ID
  title: string;            // 简历名称 (如: "Java后端开发简历")
  targetRole: string;       // 求职意向/目标岗位 (如: "针对互联网大厂")
  
  // --- 核心结构化数据 (AI 提问的主要依据) ---
  
  // 1. 个人基本信息
  personalInfo: PersonalInfo; 
  
  // 2. 教育经历
  educationList: Education[]; 
  
  // 3. 工作/实习经历
  experienceList: Experience[];
  
  // 4. 项目经历
  projectList: Project[];     
  
  // 5. 技能与评价
  skills: string[];         // 技能标签 (如: ["Java", "Spring Boot", "MySQL", "Redis"])
  selfEvaluation?: string;  // 自我评价 (一段文本)

  // --- 扩展与源数据 ---
  
  // 预留：原始简历图片/文档路径 (用于后续展示或重新 OCR 识别)
  sourceImageUrls?: string[]; // 支持多页简历图片
  sourcePdfUrl?: string;      // 原始 PDF 文件路径
  
  // 简历解析状态 (应对后续上传图片异步识别的场景)
  parseStatus: ResumeParseStatus; 

  // --- 元数据 ---
  createTime: number;       // 创建时间戳
  updateTime: number;       // 最后更新时间戳
}

/**
 * 简历解析状态枚举
 */
export enum ResumeParseStatus {
  UNPARSED = 'UNPARSED',       // 未解析 (仅上传了图片/文件)
  PARSING = 'PARSING',         // OCR/AI 解析中
  COMPLETED = 'COMPLETED',     // 解析完成并已结构化
  FAILED = 'FAILED'            // 解析失败
}

/**
 * 个人基本信息
 */
export interface PersonalInfo {
  name: string;             // 姓名
  gender?: 'MALE' | 'FEMALE' | 'OTHER'; // 性别
  age?: number;             // 年龄
  phone: string;            // 手机号
  email: string;            // 邮箱
  avatarUrl?: string;       // 简历证件照
  wechat?: string;          // 微信
  github?: string;          // GitHub 主页
  blog?: string;            // 个人博客
  currentCity?: string;     // 所在城市
}

/**
 * 教育经历
 */
export interface Education {
  id: string;
  schoolName: string;       // 学校名称
  major: string;            // 专业名称
  degree: string;           // 学历 (大专/本科/硕士/博士)
  startTime: string;        // 入学时间 (如: "2018-09")
  endTime: string;          // 毕业时间 (如: "2022-07")
  isEduBackgroundInfo?: string; // 附加信息 (如: "985/211", "GPA 3.8/4.0")
}

/**
 * 工作/实习经历
 */
export interface Experience {
  id: string;
  companyName: string;      // 公司名称
  role: string;             // 职位/角色
  department?: string;      // 所属部门
  startTime: string;        // 开始时间
  endTime: string;          // 结束时间 (传 "至今" 表示在职)
  description: string;      // 工作内容描述 (详细职责)
}

/**
 * 项目经历
 */
export interface Project {
  id: string;
  projectName: string;      // 项目名称
  role: string;             // 担任角色 (如: "核心开发", "项目负责人")
  description: string;      // 项目背景与整体描述
  responsibilities: string; // 个人具体职责与工作内容
  achievements?: string;    // 项目难点攻克与最终成果/业绩
}

/**
 * 简历列表卡片的数据模型 (轻量级摘要)
 */
export interface ResumeCardModel {
  id: string;             // 简历的唯一标识
  title: string;          // 简历主标题 (如: 'Java后端开发简历')
  date: string;           // 简历更新或创建的日期 (如: '3月7日')
}