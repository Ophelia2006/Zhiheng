import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { GenericBasicDataSource } from '@ohos/model/src/main/ets/utils/GenericBasicDataSource';
import { ResumeCardModel } from '@ohos/model/src/main/ets/Resume';
import { ProfileCard } from '../components/ProfileCard'
import { ResumeApi } from '@ohos/network'
import { ResumeViewModel } from '../viewmodels/ResumeViewModel'

class ProfileDataSource extends GenericBasicDataSource<ResumeCardModel> {
  public moveDataWithoutNotify(from: number, to: number): void {
    let tmp = this.originDataArray.splice(from, 1);
    this.originDataArray.splice(to, 0, tmp[0]);
  }

  public deleteData(index: number) {
    this.originDataArray.splice(index, 1); // 删除数据
    this.notifyDataDelete(index); // 通知框架删除对应索引组件
  }
}

@Component
export struct ProfileComponent {
  @State isRefreshing: boolean = false;
  private resumeViewModel: ResumeViewModel = new ResumeViewModel()
  private profileData: ProfileDataSource = new ProfileDataSource();
  profileList: ResumeCardModel[] = []

  async loadData() {
    try {
      this.profileList = await ResumeApi.getResumeList()
      hilog.debug(0, 'ProfileComponent', `${JSON.stringify(this.profileList)}`)
      this.profileData.setDataArray(this.profileList);
      hilog.debug(0, 'ProfileComponent', `profileData内容 ${JSON.stringify(this.profileData)}`)
    } catch (error) {
      hilog.error(0, 'ProfileComponent', `获取数据失败: ${error}`);
    }
  }

  async aboutToAppear(): Promise<void> {
    await this.loadData();
  }

  @Builder
  DeleteBuilder(item: ResumeCardModel, index: number) {
    Button() {
      // 使用系统的删除图标或自定义文本
      Image($r('app.media.user_avatar_example'))
        .width(24)
        .height(24)
        .fillColor(Color.White)
    }
    .type(ButtonType.Normal)
    .backgroundColor(Color.Transparent)
    .height('100%')
    .width(80)
    .borderRadius({ topRight: 12, bottomRight: 12 })
    .onClick(async () => {
      hilog.info(0, 'ProfileComponent', `点击删除简历 ID: ${item.id}`);
      try {
        // 调用接口删除后端数据
        const success = await ResumeApi.deleteResume(item.id);
        if (success) {
          // 从数据源中移除该项，触发 UI 更新
          this.profileData.deleteData(index);
          hilog.info(0, 'ProfileComponent', '删除成功');
        } else {
          hilog.error(0, 'ProfileComponent', '删除失败，接口返回 false');
        }
      } catch (error) {
        hilog.error(0, 'ProfileComponent', `删除简历出现异常: ${error}`);
      }
    })
  }

  build() {
    Column() {

      Refresh({ refreshing: $$this.isRefreshing }) {
        // 简历列表
        List({ space: 15 }) {
          LazyForEach(this.profileData, (item: ResumeCardModel, index: number) => {
            ListItem() {
              ProfileCard({
                title: item.title,
                date: item.date
              })
                .reuseId('profile')
            }
            // 绑定右侧滑出的删除按钮
            .swipeAction({ end: this.DeleteBuilder(item, index) })
            .onClick(() => {
              // 通过路由将简历 ID 传递到详情页面
              const params: Record<string, Object> = { 'id': item.id };
              // await this.resumeViewModel.loadResumeDetail(item.id)
              buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MINE_RESUME, params);
            })
          },
            (item: ResumeCardModel) => item.id.toString())
            .onMove((from: number, to: number) => {
              this.profileData.moveDataWithoutNotify(from, to);
            })
        }
        .cachedCount(3)
        .width('100%')
        .height('100%')
        .padding({ left: 20, right: 20 })
        .scrollBar(BarState.Off)
      }
      .layoutWeight(1)
      .width('100%')
      .onRefreshing(async () => {
        await this.loadData();
        this.isRefreshing = false;
      })

      // 底部按钮区域
      Row() {
        // 手动添加按钮
        Button() {
          Column() {
            // 图标占位
            Stack({ alignContent: Alignment.Center }) {
              Circle({ width: 24, height: 24 })
                .fill('#333333')
              Text('+')
                .fontSize(16)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
            }
            .margin({ bottom: 8 })

            Text('手动添加')
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#F0F9F6')
        .borderRadius(16)
        .width(140)
        .height(100)
        .onClick(() => {
          // TODO: 手动添加逻辑
          buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.MINE_ADDRESUME);

        })

        // 自动导入按钮
        Button() {
          Column() {
            // 图标占位
            Stack({ alignContent: Alignment.Center }) {
              Rect({ width: 18, height: 22 })
                .fill('#333333')
                .radius(2)
              Image($r('app.media.right_arrow'))
                .width(14)
                .height(14)
                .fillColor(Color.White)
            }
            .margin({ bottom: 8 })

            Text('自动导入')
              .fontSize(14)
              .fontColor('#333333')
              .fontWeight(FontWeight.Medium)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
        }
        .type(ButtonType.Normal)
        .backgroundColor('#F0F9F6')
        .borderRadius(16)
        .width(140)
        .height(100)
        .onClick(() => {
          // TODO: 自动导入逻辑
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
