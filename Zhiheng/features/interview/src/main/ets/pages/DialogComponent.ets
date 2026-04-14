import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';

import { Message, MessageType } from '../model/Message';
import { InterviewViewModel, InterviewStatus } from '../viewmodels/InterviewViewModel';
import image from '@ohos.multimedia.image';

@Component
export struct DialogComponent {
  @State viewModel: InterviewViewModel = new InterviewViewModel();
  @State inputText: string = '';
  // 接收路由传过来的参数
  @Prop routerParams: Record<string, string>;
  
  scroller: Scroller = new Scroller();

  aboutToAppear() {
    // 尝试获取传入的 formId
    const formId = (this.routerParams && this.routerParams['formId']) ? this.routerParams['formId'] : '';
    // 初始化面试
    if (formId) {
      this.viewModel.initInterview(formId);
    }
  }

  build() {
    Column() {
      // 1. Header
      Row() {
        // Back Button
        Button({ type: ButtonType.Circle, stateEffect: false }) {
          Image($r('app.media.left_arrow'))
            .width(24)
            .height(24)
        }
        .backgroundColor(Color.White)
        .width(40)
        .height(40)
        .onClick(() => {
          RouterModule.pop(RouterNameConstants.ENTRY_HAP)
        })

        // Title
        Text(this.viewModel.status === InterviewStatus.PREPARING ? '待开始' : 
             this.viewModel.status === InterviewStatus.IN_PROGRESS ? '面试中' : '已结束')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        // More Options (Placeholder)
        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Text('...')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .backgroundColor(Color.White)
        .width(40)
        .height(40)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Color.Transparent)

      // 2. Chat List
      List({ scroller: this.scroller, initialIndex: this.viewModel.messages.length - 1 }) {
        ForEach(this.viewModel.messages, (msg: Message) => {
          ListItem() {
            Row() {
              if (msg.isUser) {
                // User Message Bubble
                Row() {
                  // Message Content
                  Column() {
                    Text(msg.content)
                      .fontSize(16)
                      .fontColor($r('app.color.text_primary'))
                      .lineHeight(24)
                  }
                  .backgroundColor($r('app.color.green_tabs'))
                  .padding(16)
                  .borderRadius({topLeft: 16 ,topRight:0,bottomLeft: 16,bottomRight:16})
                  // 移除 layoutWeight(1)，防止强制撑满，改用 constraintSize 限制最大宽度
                  .constraintSize({ maxWidth: '75%' })
                  .shadow({ radius: 5, color: $r('app.color.shadow_color'), offsetX: 0, offsetY: 2 })

                  // User Avatar
                  Image($r('app.media.user_avatar_example'))
                    .width(40)
                    .aspectRatio(1)
                    .borderRadius(90)
                    .margin({ left: 10 })
                }
                .width('100%')
                .justifyContent(FlexAlign.End)
                .alignItems(VerticalAlign.Top)
              } else {
                // AI Message Bubble
                Row() {
                  // AI Avatar
                  Image($r('app.media.zhiheng_avatar'))
                    .width(40)
                    .aspectRatio(1)
                    .borderRadius(90)
                    .margin({ right: 10 })
                    
                  // Message Content
                  Column() {
                    Text(msg.content)
                      .fontSize(16)
                      .fontColor($r('app.color.text_primary'))
                      .lineHeight(24)
                  }
                  .backgroundColor($r('app.color.grey_ai_chat_bg'))
                  .padding(16)
                  .borderRadius({topLeft: 0 ,topRight:16,bottomLeft: 16,bottomRight:16})
                  // 使用 constraintSize 限制最大宽度，实现自适应
                  .constraintSize({ maxWidth: '75%' })
                  .shadow({ radius: 5, color: $r('app.color.shadow_color'), offsetX: 0, offsetY: 2 })
                }
                .width('100%')
                .justifyContent(FlexAlign.Start)
                .alignItems(VerticalAlign.Top)
              }
            }
            .width('100%')
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          }
        }, (msg: Message) => msg.id)
      }
      .layoutWeight(1)
      .width('100%')
      // .backgroundColor($r('app.color.page_background'))

      // 3. Input Area
      if (this.viewModel.status === InterviewStatus.PREPARING) {
        // 待开始状态，显示“开始面试”按钮
        Row() {
          Button(this.viewModel.isLoading ? '正在准备面试...' : '开始面试')
            .width('100%')
            .height(48)
            .backgroundColor(this.viewModel.isLoading ? Color.Gray : $r('app.color.black_selected'))
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(24)
            .enabled(!this.viewModel.isLoading) // 加载期间按钮不可用
            .onClick(() => {
              this.viewModel.startInterview().then(() => {
                setTimeout(() => {
                  this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
                }, 100);
              });
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(Color.Transparent)
      } else if (this.viewModel.status === InterviewStatus.REPORT_FAILED) {
        // 报告生成失败状态，显示“重新生成”按钮
        Row() {
          Button(this.viewModel.isLoading ? '正在重新生成...' : '重新生成报告')
            .width('100%')
            .height(48)
            .backgroundColor(this.viewModel.isLoading ? Color.Gray : '#E53935') // 失败重试通常用红色或警告色
            .fontColor(Color.White)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .borderRadius(24)
            .enabled(!this.viewModel.isLoading)
            .onClick(() => {
              this.viewModel.generateInterviewReport().then(() => {
                setTimeout(() => {
                  this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
                }, 100);
              });
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(Color.Transparent)
      } else {
        // 面试中/已结束状态，显示输入框
        Row() {
          TextInput({ placeholder: this.viewModel.isLoading ? 'AI正在思考中...' : 
                                   this.viewModel.status === InterviewStatus.FINISHED ? '面试已结束' : '去回答...', text: this.inputText })
            .layoutWeight(1)
            .height(48)
            .borderRadius(24)
            .backgroundColor(Color.White)
            .padding({ left: 20, right: 20 })
            .enabled(!this.viewModel.isLoading && this.viewModel.status !== InterviewStatus.FINISHED)
            .onChange((value: string) => {
              this.inputText = value;
            })
            .onSubmit(() => {
              if (!this.viewModel.isLoading && this.viewModel.status !== InterviewStatus.FINISHED) {
                this.sendMessage();
              }
            })

          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Text('➤') // Send icon placeholder
              .fontSize(20)
              .fontColor(Color.White)
          }
          .width(48)
          .height(48)
          .backgroundColor(this.viewModel.isLoading || this.viewModel.status === InterviewStatus.FINISHED ? Color.Gray : $r('app.color.black_selected'))
          .margin({ left: 12 })
          .enabled(!this.viewModel.isLoading && this.viewModel.status !== InterviewStatus.FINISHED)
          .onClick(() => {
            this.sendMessage();
          })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .height('100%')
    // .backgroundColor($r('app.color.green_background'))
  }

  sendMessage() {
    if (this.inputText.trim() === '') return;

    const userInput = this.inputText;
    this.inputText = ''; // Clear input

    // 调用 ViewModel 处理用户输入
    this.viewModel.sendUserAnswer(userInput).then(() => {
      // 等待状态更新后，滚动到底部
      setTimeout(() => {
        this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
      }, 100);
    });

    // 立即滚动到底部（展示用户发送的消息）
    setTimeout(() => {
      this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
    }, 50);
  }
}
