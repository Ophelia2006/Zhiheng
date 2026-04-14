import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { AuthService, User } from '@ohos/auth';
import photoAccessHelper from '@ohos.file.photoAccessHelper';
import { hilog } from '@kit.PerformanceAnalysisKit';
import fs from '@ohos.file.fs';
import dataPreferences from '@ohos.data.preferences';
import { common } from '@kit.AbilityKit';

@Component
export struct PersonalPage {
  @StorageProp('currentUser') @Watch('onUserChange') currentUser: User | null = null;
  @State selectedAvatarUri: string = ''; // 临时保存选中的图片URI

  aboutToAppear() {
    this.loadLocalAvatar();
  }

  // 用户信息变更时触发（如退出登录、切换账号）
  async onUserChange() {
    // 恢复为初始的模拟头像
    this.selectedAvatarUri = '';
    
    // 清除本地持久化的头像路径
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let preferences = await dataPreferences.getPreferences(context, 'user_prefs');
      await preferences.delete('local_avatar_path');
      await preferences.flush();
      hilog.info(0x0000, 'PersonalPage', 'Local avatar path cleared due to user change.');
    } catch (error) {
      hilog.error(0x0000, 'PersonalPage', `onUserChange error: ${JSON.stringify(error)}`);
    }
  }

  // 加载本地持久化的头像
  async loadLocalAvatar() {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let preferences = await dataPreferences.getPreferences(context, 'user_prefs');
      let savedPath = await preferences.get('local_avatar_path', '') as string;
      if (savedPath) {
        // 检查文件是否存在
        let res = fs.accessSync(savedPath);
        if (res) {
          this.selectedAvatarUri = 'file://' + savedPath;
          hilog.info(0x0000, 'PersonalPage', `Loaded local avatar: ${this.selectedAvatarUri}`);
        }
      }
    } catch (error) {
      hilog.error(0x0000, 'PersonalPage', `loadLocalAvatar error: ${JSON.stringify(error)}`);
    }
  }

  // 保存图片到沙箱并持久化路径
  async saveAvatarToSandbox(uri: string) {
    try {
      let context = getContext(this) as common.UIAbilityContext;
      let filesDir = context.filesDir;
      // 提取原始文件扩展名，默认为 jpg
      let extension = uri.includes('.') ? uri.split('.').pop() : 'jpg';
      let fileName = `avatar_${Date.now()}.${extension}`;
      let targetPath = `${filesDir}/${fileName}`;

      // 打开相册图片并拷贝到沙箱目录
      let file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
      fs.copyFileSync(file.fd, targetPath);
      fs.closeSync(file);

      // 保存路径到 Preferences
      let preferences = await dataPreferences.getPreferences(context, 'user_prefs');
      await preferences.put('local_avatar_path', targetPath);
      await preferences.flush();

      hilog.info(0x0000, 'PersonalPage', `Avatar saved to sandbox: ${targetPath}`);
      // 更新UI绑定的路径（需加 file:// 前缀才能被 Image 组件识别为本地绝对路径）
      this.selectedAvatarUri = 'file://' + targetPath;

    } catch (error) {
      hilog.error(0x0000, 'PersonalPage', `saveAvatarToSandbox error: ${JSON.stringify(error)}`);
    }
  }

  // 打开相册选择器
  async openPhotoPicker() {
    try {
      let photoPicker = new photoAccessHelper.PhotoViewPicker();
      let options = new photoAccessHelper.PhotoSelectOptions();
      options.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE; // 仅选择图片
      options.maxSelectNumber = 1; // 单选

      photoPicker.select(options).then((photoSelectResult) => {
        if (photoSelectResult && photoSelectResult.photoUris && photoSelectResult.photoUris.length > 0) {
          let originalUri = photoSelectResult.photoUris[0];
          hilog.info(0x0000, 'PersonalPage', `Selected photo URI: ${originalUri}`);
          // 将选中的图片拷贝到沙箱并保存路径
          this.saveAvatarToSandbox(originalUri);
        }
      }).catch((err: Error) => {
        hilog.error(0x0000, 'PersonalPage', `PhotoPicker select failed: ${JSON.stringify(err)}`);
      });
    } catch (error) {
      hilog.error(0x0000, 'PersonalPage', `openPhotoPicker error: ${JSON.stringify(error)}`);
    }
  }

  build() {
    Scroll() {
      Column() {

        // Header Section
        Column() {
          // Avatar with shadow/border like effect
          Stack({ alignContent: Alignment.Center }) {
            Circle()
              .width(90)
              .height(90)
              .fill('#F0F0F0')
            Image(this.selectedAvatarUri ? this.selectedAvatarUri : (this.currentUser?.avatarUrl ? this.currentUser.avatarUrl : $r('app.media.initial_user')))
              .width(80)
              .height(80)
              .borderRadius(40)
              .onClick(() => {
                this.openPhotoPicker();
              })
          }
          .margin({ top: 20, bottom: 20 })

          Text(this.currentUser?.username || '未登录用户')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1A1A1A')

          Row() {
            Text(`@${this.currentUser?.id || 'guest'}`)
              .fontSize(16)
              .fontColor('#B0B0B0')
          }
          .margin({ top: 8, bottom: 30 })
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({ left: 30, right: 30 })

        // Cards Section
        Grid() {
          // Resume Card
          GridItem() {
            Column() {
              Image($r('app.media.profile')) // Megaphone icon placeholder
                .width(22)
                .height(22)
                .margin({ bottom: 12 })
                .fillColor('#FFFFFF')
              
              Text('简历')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('简历待投递面试')
                .fontSize(12)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .aspectRatio(2)
            .backgroundColor('#1EC18D')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
            .onClick(()=>{
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MINE_PROFILE);

            })
          }
          .columnStart(0)
          .columnEnd(1)

          // Security Card
          GridItem() {
            Column() {
              Image($r('app.media.account')) // Lock icon placeholder
                .width(22)
                .height(22)
                .margin({ bottom: 12 })
                .fillColor('#FFFFFF')
              
              Text('账号与安全')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('管理账号信息')
                .fontSize(12)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .aspectRatio(1)
            .backgroundColor('#0D8E81')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
          }
          .onClick(()=>{
            buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MINE_ACCOUNT);

          })

          // Docs Card
          GridItem() {
            Column() {
              Image($r('app.media.about_us')) // Doc icon placeholder
                .width(22)
                .height(22)
                .margin({ bottom: 12 })
                .fillColor('#FFFFFF')
              
              Text('关于我们')
                .fontSize(16)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFFFFF')
                .margin({ bottom: 4 })
              
              Text('让我们变得更好')
                .fontSize(12)
                .fontColor('#FFFFFF')
                .opacity(0.8)
            }
            .width('100%')
            .aspectRatio(1)
            .backgroundColor('#0D7174')
            .borderRadius(25)
            .padding(25)
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Start)
          }
        }
        .width('100%')
        .columnsTemplate('1fr 1fr')
        .columnsGap(15)
        .rowsGap(15)
        .padding({ left: 30, right: 30 })
      }
      .width('100%')
    }
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.None)
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
