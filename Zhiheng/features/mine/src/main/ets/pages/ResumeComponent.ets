import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import {
  Resume,
  ResumeParseStatus,
  PersonalInfo,
  Education,
  Experience,
  Project
} from '@ohos/model/src/main/ets/Resume';
import { LengthMetrics } from '@kit.ArkUI';
import { ResumeViewModel } from '../viewmodels/ResumeViewModel';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { User } from '@ohos/auth';
import dataPreferences from '@ohos.data.preferences';
import fs from '@ohos.file.fs';
import { common } from '@kit.AbilityKit';

@Component
export struct ResumeComponent {
  resumeId: string = '';
  // 引入 ViewModel，但它不再作为 @State，因为它现在是一个无状态的服务类
  private viewModel: ResumeViewModel = new ResumeViewModel();
  // 组件自身维护响应式状态
  @State isLoading: boolean = true;
  @State resume: Resume | null = null;
  @State errorMessage: string = ''
  @State isEditing: boolean = false; // 新增状态：控制查看与编辑模式
  // 接收路由参数
  @Prop routerParams: Record<string, string>;
  
  @StorageProp('currentUser') currentUser: User | null = null;
  @State localAvatarUri: string = ''; // 本地存储的头像URI

  async aboutToAppear() {
    this.loadLocalAvatar();
    
    // 从路由参数中获取真正的 resumeId，如果没有则使用默认的
    const passedId = (this.routerParams && this.routerParams['id']) ? this.routerParams['id'] : '';

    // 如果上个页面通过 params 传过来了，就使用传递过来的 id
    if (passedId) {
      this.resumeId = passedId;
    }

    hilog.info(0x0000, 'ResumeComponent', `获取到的resume id: ${this.resumeId}`);

    if (this.resumeId && this.resumeId !== '0000000000000') {
      try {
        this.isLoading = true;
        this.errorMessage = '';
        this.resume = await this.viewModel.loadResumeDetail(this.resumeId);
      } catch (err) {
        const error = err as Error
        this.errorMessage = '获取简历详情失败';
        hilog.error(0, 'ResumeComponent', `${JSON.stringify(error)}`)
      } finally {
        this.isLoading = false;
      }
    } else {
      // 预留空白结构或者在进入组件前传参
      this.resume = this.viewModel.getEmptyResume();
      this.isLoading = false;
    }
  }

  // 加载本地持久化的头像
  async loadLocalAvatar() {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let preferences = await dataPreferences.getPreferences(context, 'user_prefs');
      let savedPath = await preferences.get('local_avatar_path', '') as string;
      if (savedPath) {
        let res = fs.accessSync(savedPath);
        if (res) {
          this.localAvatarUri = 'file://' + savedPath;
        }
      }
    } catch (error) {
      hilog.error(0x0000, 'ResumeComponent', `loadLocalAvatar error: ${JSON.stringify(error)}`);
    }
  }

  build() {
    Column() {
      // 自定义标题栏
      Row() {
        Image($r('app.media.left_arrow')) // 左箭头
          .width(20)
          .height(20)
          .fillColor('#333333')
          .onClick(() => {
            RouterModule.pop(RouterNameConstants.ENTRY_HAP);
          })

        Text('我的简历')
          .margin({ left: 50 })
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#333333')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // 使用 Toggle 替换保存按钮，切换查看和编辑模式
        Row() {
          Text(this.isEditing ? '编辑' : '阅览')
            .fontSize(14)
            .fontColor(this.isEditing ? '#1EC18D' : '#999999')
            .margin({ right: 6 })

          Toggle({ type: ToggleType.Switch, isOn: this.isEditing })
            .id('resumeEditToggle')
            .selectedColor('#1EC18D')
            .onChange(async (isOn: boolean) => {
              // 当从编辑状态切换为查看状态时，触发保存逻辑
              if (this.isEditing && !isOn) {
                if (this.resume) {
                  const success = await this.viewModel.saveResume(this.resume);
                  if (success) {
                    hilog.info(0x0000, 'ResumeComponent', '简历保存成功');
                  }
                }
              }
              // 更新编辑状态
              this.isEditing = isOn;
            })
        }
      }
      .width('100%')
      .height(56)
      .padding({ left: 20, right: 20 })
      .backgroundColor('#FFFFFF')

      if (this.isLoading) {
        LoadingProgress()
          .width(50)
          .height(50)
          .margin({ top: 100 })
      } else if (this.errorMessage) {
        Text(this.errorMessage)
          .fontSize(16)
          .fontColor(Color.Red)
          .margin({ top: 100 })
      } else if (this.resume) {
        Scroll() {
          Column({ space: 15 }) {

            // 1. 个人基本信息
            this.PersonalInfoCard(this.resume.personalInfo, this.resume.targetRole)

            // 2. 个人技能
            if ((this.resume.skills && this.resume.skills.length > 0) || this.isEditing) {
              this.SkillsCard(this.resume.skills || [])
            }

            // 3. 教育经历
            if ((this.resume.educationList && this.resume.educationList.length > 0) || this.isEditing) {
              this.EducationCard(this.resume.educationList || [])
            }

            // 4. 工作经历
            if ((this.resume.experienceList && this.resume.experienceList.length > 0) || this.isEditing) {
              this.ExperienceCard(this.resume.experienceList || [])
            }

            // 5. 项目经历
            if ((this.resume.projectList && this.resume.projectList.length > 0) || this.isEditing) {
              this.ProjectCard(this.resume.projectList || [])
            }

            // 6. 自我评价
            if (this.resume.selfEvaluation || this.isEditing) {
              this.SelfEvaluationCard(this.resume.selfEvaluation || '')
            }
          }
          .width('100%')
          .padding({
            left: 15,
            right: 15,
            top: 15,
            bottom: 40
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor('#F5F7FA')
      }
    }
    .width('100%')
    .height('100%')
  }

  // --- UI 组件 Builders ---

  @Builder
  SectionTitle(title: string) {
    Row() {
      Rect({ width: 4, height: 16 }).fill('#1EC18D').radius(2).margin({ right: 8 })
      Text(title).fontSize(16).fontWeight(FontWeight.Bold).fontColor('#333333')
    }
    .width('100%')
    .margin({ bottom: 15 })
  }

  @Builder
  PersonalInfoCard(info: PersonalInfo, targetRole: string) {
    Column() {
      Row() {
        Column() {
          if (this.isEditing) {
            TextInput({ text: info.name, placeholder: '姓名' })
              .borderRadius(0)
              .fontSize(24)
              .fontWeight(FontWeight.Bolder)
              .fontColor('#333333')
              .margin({ bottom: 8 })
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onChange((v: string) => {
                info.name = v
              })
            Row() {
              Text('求职意向：').fontSize(14).fontColor('#1EC18D').fontWeight(FontWeight.Medium)
              TextInput({ text: targetRole, placeholder: '求职意向' })
                .fontSize(14)
                .fontColor('#1EC18D')
                .fontWeight(FontWeight.Medium)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .layoutWeight(1)
                .onChange((v: string) => {
                  if (this.resume) {
                    this.resume.targetRole = v
                  }
                })
            }.width('100%')
          } else {
            Text(info.name).fontSize(24).fontWeight(FontWeight.Bolder).fontColor('#333333').margin({ bottom: 8 })
            Text(`求职意向：${targetRole}`).fontSize(14).fontColor('#1EC18D').fontWeight(FontWeight.Medium)
          }
        }.alignItems(HorizontalAlign.Start).layoutWeight(1)

        // 假装有个头像 -> 替换为真实用户头像
        Image(this.localAvatarUri ? this.localAvatarUri : (this.currentUser?.avatarUrl ? this.currentUser.avatarUrl : $r('app.media.initial_user')))
          .width(60)
          .height(60)
          .borderRadius(30)
      }.width('100%').margin({ bottom: 15 })

      Divider().color('#F0F0F0').margin({ bottom: 15 })

      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
        if (info.age) {
          this.InfoTag(`${info.age}岁`)
        }
      }.width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  InfoTag(text: string) {
    if (text) {
      Text(text)
        .fontSize(13)
        .fontColor('#666666')
        .backgroundColor('#F5F7FA')
        .padding({
          left: 10,
          right: 10,
          top: 4,
          bottom: 4
        })
        .borderRadius(4)
    }
  }

  @Builder
  SkillsCard(skills: string[]) {
    Column() {
      this.SectionTitle('专业技能')
      if (this.isEditing) {
        TextArea({ text: skills.join('\n'), placeholder: '请输入专业技能，每行一个' })
          .fontSize(13)
          .fontColor('#1EC18D')
          .backgroundColor('#E6F9F0')
          .padding(12)
          .borderRadius(12)
          .width('100%')
          .onChange((v: string) => {
            if (this.resume) {
              this.resume.skills = v.split('\n').filter(s => s.trim() !== '');
            }
          })
      } else {
        Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(8), cross: LengthMetrics.vp(8) } }) {
          ForEach(skills, (skill: string) => {
            Text(skill)
              .fontSize(13)
              .fontColor('#1EC18D')
              .backgroundColor('#E6F9F0')
              .padding({
                left: 12,
                right: 12,
                top: 6,
                bottom: 6
              })
              .borderRadius(16)
          }, (skill: string) => skill)
        }.width('100%')
      }
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  EducationCard(eduList: Education[]) {
    Column() {
      this.SectionTitle('教育经历')
      ForEach(eduList, (edu: Education, index: number) => {
        Column() {
          if (this.isEditing) {
            Row() {
              TextInput({ text: edu.schoolName, placeholder: '学校名称' })
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  edu.schoolName = v
                })
              TextInput({ text: edu.startTime, placeholder: '开始时间' })
                .fontSize(12)
                .fontColor('#999999')
                .backgroundColor(Color.Transparent)
                .padding(0)
                .width(70)
                .onChange((v: string) => {
                  edu.startTime = v
                })
              Text(' - ').fontSize(12).fontColor('#999999')
              TextInput({ text: edu.endTime, placeholder: '结束时间' })
                .fontSize(12)
                .fontColor('#999999')
                .backgroundColor(Color.Transparent)
                .padding(0)
                .width(70)
                .onChange((v: string) => {
                  edu.endTime = v
                })
            }.width('100%').margin({ bottom: 6 })

            Row() {
              TextInput({ text: edu.major, placeholder: '专业' })
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  edu.major = v
                })
              Text(' | ').fontSize(14).fontColor('#666666')
              TextInput({ text: edu.degree, placeholder: '学历' })
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  edu.degree = v
                })
            }.width('100%').margin({ bottom: 4 })

            TextInput({ text: edu.isEduBackgroundInfo || '', placeholder: '附加信息' })
              .fontSize(12)
              .fontColor('#999999')
              .width('100%')
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onChange((v: string) => {
                edu.isEduBackgroundInfo = v
              })

          } else {
            Row() {
              Text(edu.schoolName).fontSize(15).fontWeight(FontWeight.Bold).fontColor('#333333').layoutWeight(1)
              Text(`${edu.startTime} - ${edu.endTime}`).fontSize(12).fontColor('#999999')
            }.width('100%').margin({ bottom: 6 })

            Row() {
              Text(`${edu.major} | ${edu.degree}`)
                .fontSize(14)
                .fontColor('#666666')
                .layoutWeight(1)
            }.width('100%').margin({ bottom: 4 })

            if (edu.isEduBackgroundInfo) {
              Text(edu.isEduBackgroundInfo).fontSize(12).fontColor('#999999').width('100%')
            }
          }

          if (index < eduList.length - 1) {
            Divider().color('#F0F0F0').margin({ top: 15, bottom: 15 })
          }
        }.width('100%')
      }, (edu: Education) => edu.id)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  ExperienceCard(expList: Experience[]) {
    Column() {
      this.SectionTitle('工作经历')
      ForEach(expList, (exp: Experience, index: number) => {
        Column() {
          if (this.isEditing) {
            Row() {
              TextInput({ text: exp.companyName, placeholder: '公司名称' })
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  exp.companyName = v
                })
              TextInput({ text: exp.startTime, placeholder: '开始时间' })
                .fontSize(12)
                .fontColor('#999999')
                .backgroundColor(Color.Transparent)
                .padding(0)
                .width(70)
                .onChange((v: string) => {
                  exp.startTime = v
                })
              Text(' - ').fontSize(12).fontColor('#999999')
              TextInput({ text: exp.endTime, placeholder: '结束时间' })
                .fontSize(12)
                .fontColor('#999999')
                .backgroundColor(Color.Transparent)
                .padding(0)
                .width(70)
                .onChange((v: string) => {
                  exp.endTime = v
                })
            }.width('100%').margin({ bottom: 6 })

            Row() {
              TextInput({ text: exp.department || '', placeholder: '部门' })
                .fontSize(14)
                .fontColor('#1EC18D')
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  exp.department = v
                })
              Text(' | ').fontSize(14).fontColor('#1EC18D')
              TextInput({ text: exp.role, placeholder: '职位' })
                .fontSize(14)
                .fontColor('#1EC18D')
                .fontWeight(FontWeight.Medium)
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  exp.role = v
                })
            }.width('100%').margin({ bottom: 10 })

            TextArea({ text: exp.description, placeholder: '工作描述' })
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onChange((v: string) => {
                exp.description = v
              })

          } else {
            Row() {
              Text(exp.companyName).fontSize(15).fontWeight(FontWeight.Bold).fontColor('#333333').layoutWeight(1)
              Text(`${exp.startTime} - ${exp.endTime}`).fontSize(12).fontColor('#999999')
            }.width('100%').margin({ bottom: 6 })

            Text(`${exp.department ? exp.department + ' | ' : ''}${exp.role}`)
              .fontSize(14)
              .fontColor('#1EC18D')
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .margin({ bottom: 10 })

            Text(exp.description)
              .fontSize(14).fontColor('#666666').lineHeight(22).width('100%')
          }

          if (index < expList.length - 1) {
            Divider().color('#F0F0F0').margin({ top: 15, bottom: 15 })
          }
        }.width('100%')
      }, (exp: Experience) => exp.id)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  ProjectCard(projList: Project[]) {
    Column() {
      this.SectionTitle('项目经历')
      ForEach(projList, (proj: Project, index: number) => {
        Column() {
          if (this.isEditing) {
            Row() {
              TextInput({ text: proj.projectName, placeholder: '项目名称' })
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor('#333333')
                .layoutWeight(1)
                .backgroundColor(Color.Transparent)
                .padding(0)
                .onChange((v: string) => {
                  proj.projectName = v
                })
              TextInput({ text: proj.role, placeholder: '担任角色' })
                .fontSize(13)
                .fontColor('#1EC18D')
                .backgroundColor('#E6F9F0')
                .padding({
                  left: 6,
                  right: 6,
                  top: 2,
                  bottom: 2
                })
                .borderRadius(4)
                .width(80)
                .onChange((v: string) => {
                  proj.role = v
                })
            }.width('100%').margin({ bottom: 10 })

            Text('项目描述：')
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 4 })
            TextArea({ text: proj.description || '', placeholder: '项目描述' })
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .backgroundColor(Color.Transparent)
              .padding(0)
              .margin({ bottom: 10 })
              .onChange((v: string) => {
                proj.description = v
              })

            Text('主要职责：')
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 4 })
            TextArea({ text: proj.responsibilities || '', placeholder: '主要职责' })
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .backgroundColor(Color.Transparent)
              .padding(0)
              .margin({ bottom: 10 })
              .onChange((v: string) => {
                proj.responsibilities = v
              })

            Text('项目成果：')
              .fontSize(13)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .width('100%')
              .margin({ bottom: 4 })
            TextArea({ text: proj.achievements || '', placeholder: '项目成果' })
              .fontSize(14)
              .fontColor('#666666')
              .width('100%')
              .backgroundColor(Color.Transparent)
              .padding(0)
              .onChange((v: string) => {
                proj.achievements = v
              })

          } else {
            Row() {
              Text(proj.projectName).fontSize(15).fontWeight(FontWeight.Bold).fontColor('#333333').layoutWeight(1)
              Text(proj.role)
                .fontSize(13)
                .fontColor('#1EC18D')
                .backgroundColor('#E6F9F0')
                .padding({
                  left: 6,
                  right: 6,
                  top: 2,
                  bottom: 2
                })
                .borderRadius(4)
            }.width('100%').margin({ bottom: 10 })

            if (proj.description) {
              Text('项目描述：')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 4 })
              Text(proj.description)
                .fontSize(14)
                .fontColor('#666666')
                .lineHeight(22)
                .width('100%')
                .margin({ bottom: 10 })
            }

            if (proj.responsibilities) {
              Text('主要职责：')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 4 })
              Text(proj.responsibilities)
                .fontSize(14)
                .fontColor('#666666')
                .lineHeight(22)
                .width('100%')
                .margin({ bottom: 10 })
            }

            if (proj.achievements) {
              Text('项目成果：')
                .fontSize(13)
                .fontWeight(FontWeight.Medium)
                .fontColor('#333333')
                .width('100%')
                .margin({ bottom: 4 })
              Text(proj.achievements).fontSize(14).fontColor('#666666').lineHeight(22).width('100%')
            }
          }

          if (index < projList.length - 1) {
            Divider().color('#F0F0F0').margin({ top: 15, bottom: 15 })
          }
        }.width('100%')
      }, (proj: Project) => proj.id)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }

  @Builder
  SelfEvaluationCard(evaluation: string) {
    Column() {
      this.SectionTitle('自我评价')
      Text(evaluation)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(22)
        .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(12)
  }
}