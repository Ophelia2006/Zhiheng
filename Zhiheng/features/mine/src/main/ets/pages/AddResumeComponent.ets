import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import {
  Resume,
  ResumeParseStatus,
  PersonalInfo,
  Education,
  Experience,
  Project
} from '@ohos/model/src/main/ets/Resume';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { DatePickerComponent } from '../components/DatePickerComponent';
import { KeyboardAvoidMode } from '@kit.ArkUI';
import { ResumeApi } from '../api/ResumeApi';

@Component
export struct AddResumeComponent {
  // --- 表单状态数据 ---
  @State resumeTitle: string = '';
  @State targetRole: string = '';
  // 个人信息
  @State name: string = '';
  // 复杂列表项（这里为了简化示例，只允许填写一条，实际可扩展为动态添加列表）
  // 教育经历
  @State schoolName: string = '';
  @State major: string = '';
  @State degree: string = '';
  @State eduStartTime: string = '';
  @State eduEndTime: string = '';
  @State isEduBackgroundInfo: string = ''; // 附加信息 (如: "985/211", "GPA 3.8/4.0")
  // 工作经历
  @State companyName: string = '';
  @State department: string = ''; // 新增
  @State expRole: string = ''; // 对应 position
  @State expStartTime: string = '';
  @State expEndTime: string = '';
  @State workContent: string = ''; // 新增，替代原来的 expDescription
  // 项目经历
  @State projectName: string = '';
  @State projRole: string = '';
  @State projDescription: string = '';
  @State projResponsibilities: string = '';
  @State achievement: string = ''; // 新增
  // 技能与评价
  @State skillsStr: string = ''; // 用户用逗号分隔输入
  @State selfEvaluation: string = '';

  aboutToAppear(): void {
    this.getUIContext().setKeyboardAvoidMode(KeyboardAvoidMode.RESIZE)
  }

  build() {
    Column() {
      // 1. 标题栏
      Row() {
        Image($r('app.media.left_arrow')) // 左箭头
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
          })

        Text('添加简历')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Text('保存')
          .fontSize(16)
          .fontColor('#1EC18D')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            this.handleSave();
          })
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#FFFFFF')
      .border({ width: { bottom: 1 }, color: '#EEEEEE' })

      // 2. 表单内容区
      Scroll() {
        Column({ space: 20 }) {

          // 个人信息
          Column() {
            Text('个人信息')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('姓名', '请输入姓名', this.name, (val) => this.name = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 基础设置
          Column() {
            Text('基础设置')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('简历名称', '如: Java后端开发简历', this.resumeTitle, (val) => this.resumeTitle = val)
            this.FormInput('求职意向', '如: 高级Java工程师', this.targetRole, (val) => this.targetRole = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 教育经历
          Column() {
            Text('教育经历')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('学校名称', '如: 华中科技大学', this.schoolName, (val) => this.schoolName = val)
            this.FormInput('专业名称', '如: 计算机科学与技术', this.major, (val) => this.major = val)
            this.FormInput('学历', '如: 本科', this.degree, (val) => this.degree = val)
            Row({ space: 10 }) {
              Column() {
                DatePickerComponent({
                  label: '开始时间',
                  value: this.eduStartTime,
                  onChange: (val) => this.eduStartTime = val
                })
              }.layoutWeight(1)

              Column() {
                DatePickerComponent({
                  label: '结束时间',
                  value: this.eduEndTime,
                  onChange: (val) => this.eduEndTime = val
                })
              }.layoutWeight(1)
            }.width('100%')

            this.FormInput('附加信息', '如: 985/211 | GPA 3.8/4.0', this.isEduBackgroundInfo, (val) => this.isEduBackgroundInfo = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 工作经历
          Column() {
            Text('工作经历')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('公司名称', '请输入公司全称', this.companyName, (val) => this.companyName = val)
            this.FormInput('部门名称', '如: PCG 事业群', this.department, (val) => this.department = val)
            this.FormInput('担任职位', '如: 后端开发工程师', this.expRole, (val) => this.expRole = val)
            Row({ space: 10 }) {
              Column() {
                DatePickerComponent({
                  label: '开始时间',
                  value: this.expStartTime,
                  onChange: (val) => this.expStartTime = val
                })
              }.layoutWeight(1)

              Column() {
                DatePickerComponent({
                  label: '结束时间',
                  value: this.expEndTime,
                  onChange: (val) => this.expEndTime = val
                })
              }.layoutWeight(1)
            }.width('100%')

            this.FormTextArea('工作内容', '详细描述你的工作内容...', this.workContent,
              (val) => this.workContent = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 项目经历
          Column() {
            Text('项目经历')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('项目名称', '请输入项目名称', this.projectName, (val) => this.projectName = val)
            this.FormInput('项目角色', '如: 核心开发', this.projRole, (val) => this.projRole = val)
            this.FormTextArea('项目描述', '简要介绍项目背景...', this.projDescription,
              (val) => this.projDescription = val)
            this.FormTextArea('项目职责', '你在项目中具体做了什么...', this.projResponsibilities,
              (val) => this.projResponsibilities = val)
            this.FormTextArea('项目成就', '如: 成功支撑了 10 万 QPS 的并发峰值', this.achievement,
              (val) => this.achievement = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 技能与评价
          Column() {
            Text('技能与评价')
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 15 })
            this.FormInput('专业技能', '用逗号分隔, 如: Java,Spring,MySQL', this.skillsStr,
              (val) => this.skillsStr = val)
            this.FormTextArea('自我评价', '一句话总结自己的核心优势...', this.selfEvaluation,
              (val) => this.selfEvaluation = val)
          }.width('100%').padding(20).backgroundColor('#FFFFFF').borderRadius(12)

          // 底部留白
          Blank().height(40)
        }
        .width('100%')
        .padding(15)
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#F5F7FA')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }

  // --- 封装的表单 UI 组件 ---


  @Builder
  FormInput(label: string, placeholder: string, value: string, onChange: (val: string) => void,
    inputType: InputType = InputType.Normal) {
    Column() {
      Text(label).fontSize(13).fontColor('#666666').margin({ bottom: 6 }).width('100%')
      TextInput({ text: value, placeholder: placeholder })
        .type(inputType)
        .height(44)
        .fontSize(15)
        .backgroundColor('#F9F9F9')
        .borderRadius(8)
        .padding({ left: 12, right: 12 })
        .onChange(onChange)
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  @Builder
  DatePicker(context: UIContext) {

  }

  @Builder
  FormDatePicker(label: string, value: string, onChange: (val: string) => void) {
    Column() {
      Text(label).fontSize(13).fontColor('#666666').margin({ bottom: 6 }).width('100%')
      Row() {
        Text(value || '请选择时间')
          .fontSize(15)
          .fontColor(value ? '#333333' : '#999999')
          .layoutWeight(1)

        Image($r('app.media.right_arrow'))
          .width(16)
          .height(16)
          .fillColor('#999999')
      }
      .width('100%')
      .height(44)
      .backgroundColor('#F9F9F9')
      .borderRadius(8)
      .padding({ left: 12, right: 12 })
      .onClick(() => {
        // 设置默认选中时间，如果有原值则尝试解析，没有则默认为当前时间
        let selectedDate = new Date();
        if (value && value.includes('-')) {
          const parts = value.split('-');
          if (parts.length >= 2) {
            selectedDate = new Date(Number(parts[0]), Number(parts[1]) - 1, 1);
          }
        }

        DatePickerDialog.show({
          start: new Date("1970-1-1"),
          end: new Date("2100-12-31"),
          selected: selectedDate,
          onAccept: (value: DatePickerResult) => {
            // 获取用户选择的年月
            const year = value.year;
            // value.month 返回的是 0-11，需要加 1，并补齐两位
            const month = (value.month || 0) + 1;
            const monthStr = month < 10 ? `0${month}` : `${month}`;
            const formattedDate = `${year}-${monthStr}`;
            onChange(formattedDate);
          }
        })
      })
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  @Builder
  FormTextArea(label: string, placeholder: string, value: string, onChange: (val: string) => void) {
    Column() {
      Text(label).fontSize(13).fontColor('#666666').margin({ bottom: 6 }).width('100%')
      TextArea({ text: value, placeholder: placeholder })
        .height(100)
        .fontSize(15)
        .backgroundColor('#F9F9F9')
        .borderRadius(8)
        .padding(12)
        .onChange(onChange)
    }
    .width('100%')
    .margin({ bottom: 12 })
  }

  // --- 业务逻辑 ---

  async handleSave() {
    // 1. 将表单数据组装成符合后端接口要求的数据结构
    // 解决 ArkTS 严格模式报错：分别声明内部对象数组的类型
    const eduExp: Record<string, string> = {
      'schoolName': this.schoolName,
      'startDate': this.eduStartTime,
      'endDate': this.eduEndTime,
      'major': this.major,
      'degree': this.degree,
      'highlights': this.isEduBackgroundInfo
    };

    const workExp: Record<string, string> = {
      'companyName': this.companyName,
      'startDate': this.expStartTime,
      'endDate': this.expEndTime,
      'department': this.department,
      'position': this.expRole,
      'workContent': this.workContent
    };

    const projExp: Record<string, string> = {
      'projectName': this.projectName,
      'projectRole': this.projRole,
      'projectDescription': this.projDescription,
      'responsibility': this.projResponsibilities,
      'achievement': this.achievement
    };

    const newResumeRecord: Record<string, Object> = {
      "formName": this.resumeTitle || '未命名简历',
      "candidateName": this.name,
      "jobIntention": this.targetRole,
      "professionalSkills": this.skillsStr ? this.skillsStr.split(',').map(s => s.trim()) : [],
      "educationExperiences": [eduExp],
      "workExperiences": [workExp],
      "projectExperiences": [projExp]
    };

    // 2. 调用 API 保存到服务器
    hilog.debug(0, 'AddResumeComponent', `newResumeRecord内容 ${JSON.stringify(newResumeRecord)}`)

    try {
      // 发起创建简历的网络请求
      await ResumeApi.addResume(newResumeRecord);
      hilog.info(0, 'AddResumeComponent', '简历创建成功');

      // 3. 提示成功并返回上一页
      // 这里可以加一个 Toast 提示
      RouterModule.pop(RouterNameConstants.ENTRY_HAP);
    } catch (error) {
      hilog.error(0, 'AddResumeComponent', `简历创建失败: ${error}`);
      // 可以在这里增加失败的 Toast 提示
    }
  }
}