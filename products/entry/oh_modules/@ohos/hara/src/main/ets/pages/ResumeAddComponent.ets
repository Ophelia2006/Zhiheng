
import { Message, MessageType } from '../model/Message';
import { InterviewViewModel } from '../viewmodel/InterviewViewModel';
import image from '@ohos.multimedia.image';

@Component
export struct ResumeAddComponent {
  @State viewModel: InterviewViewModel = new InterviewViewModel();
  @State inputText: string = '';
  scroller: Scroller = new Scroller();

  build() {
    Column() {
      // 1. Header
      Row() {
        // Back Button
        Button({ type: ButtonType.Circle, stateEffect: false }) {
          Text('<')
            .fontSize(20)
            .fontColor(Color.Black)
        }
        .backgroundColor(Color.White)
        .width(40)
        .height(40)
        .onClick(() => {
          // this.pageStack.pop();
        })

        // Title
        Text('Job Finder UX')
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
                  .layoutWeight(1)
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
                Column() {
                  // AI Avatar
                  Image($r('app.media.zhiheng_avatar'))
                    .margin({ top: 10, left: 10 })
                    .aspectRatio(1)
                    .width(40)
                    .borderRadius(90)

                  // Message Content
                  Text(msg.content)
                    .fontSize(16)
                    .fontColor($r('app.color.text_primary'))
                    .lineHeight(24)
                    .margin(10)
                }
                .alignItems(HorizontalAlign.Start)
                .width('100%')
                .borderRadius(10)
                .backgroundColor($r('app.color.grey_ai_chat_bg'))
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
      Row() {
        TextInput({ placeholder: '去回答...', text: this.inputText })
          .layoutWeight(1)
          .height(48)
          .borderRadius(24)
          .backgroundColor(Color.White)
          .padding({ left: 20, right: 20 })
          .onChange((value: string) => {
            this.inputText = value;
          })
          .onSubmit(() => {
            this.sendMessage();
          })

        Button({ type: ButtonType.Circle, stateEffect: true }) {
          Text('➤') // Send icon placeholder
            .fontSize(20)
            .fontColor(Color.White)
        }
        .width(48)
        .height(48)
        .backgroundColor($r('app.color.black_selected'))
        .margin({ left: 12 })
        .onClick(() => {
          this.sendMessage();
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height('100%')
    // .backgroundColor($r('app.color.green_background'))
  }

  sendMessage() {
    if (this.inputText.trim() === '') return;

    // Add User Message
    const userMsg = this.viewModel.createUserMessage(this.inputText);
    this.viewModel.messages.push(userMsg);

    const prompt = this.inputText;
    this.inputText = ''; // Clear input

    // Scroll to bottom
    this.scroller.scrollToIndex(this.viewModel.messages.length - 1);

    // Simulate AI Response
    setTimeout(() => {
      const aiMsg = this.viewModel.createAIMessage(`Simulated response to: "${prompt}"`);
      this.viewModel.messages.push(aiMsg);
      this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
    }, 1000);
  }
}
