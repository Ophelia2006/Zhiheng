/*
* Copyright (C) 2024 Huawei Device Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { InterviewPage } from '../../../../../../features/interview'
import { ReportPage } from '../../../../../../features/report'
import { PersonalPage } from '../../../../../../features/mine'

@Entry
@Component
struct EntryHap {
  @State entryHapRouter: NavPathStack = new NavPathStack();


  @State currentIndex: number = 0;
  private controller: TabsController = new TabsController();

  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
        .fillColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a')
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.controller.changeIndex(targetIndex);
    })
  }

  aboutToAppear() {
    if (!this.entryHapRouter) {
      this.entryHapRouter = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.entryHapRouter);
  };

  @Builder
  routerMap(builderName: string, param: object) {
    // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
    RouterModule.getBuilder(builderName).builder(param);
  };

  build() {
    Navigation(this.entryHapRouter) {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          InterviewPage()
        }
        .tabBar(this.TabBuilder('面试', 0, $r('app.media.interview_selected'), $r('app.media.interview_unselected')))

        TabContent() {
          ReportPage()
        }
        .tabBar(this.TabBuilder('报告', 1, $r('app.media.report_selected'), $r('app.media.report_unselected')))

        TabContent() {
          PersonalPage()
        }
        .tabBar(this.TabBuilder('我的', 2, $r('app.media.mine_selected'), $r('app.media.mine_unselected')))
      }
      .width('100%')
      .height('100%')
      .onChange((index: number) => {
        this.currentIndex = index;
      })
    }
    .hideTitleBar(true)
    .hideToolBar(true)
    .navDestination(this.routerMap);
  }
}

