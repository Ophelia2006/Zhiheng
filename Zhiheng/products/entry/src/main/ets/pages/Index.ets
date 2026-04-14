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
import { AuthService } from '@ohos/auth';
import { InterviewPage } from '@ohos/interview';
import { ReportPage } from '@ohos/report';
import { PersonalPage } from '@ohos/mine';
import { HttpUtil,HttpResponse } from '@ohos/network/src/main/ets/utils/HttpUtil';
import { hilog } from '@kit.PerformanceAnalysisKit';
import http from '@ohos.net.http';

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
        .size({ width: 20, height: 20 })
        .fillColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a')
        .margin({ bottom: 4 })
      Text(title)
        .fontSize(12)
        .fontColor(this.currentIndex === targetIndex ? '#1b8660' : '#8a8a8a')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .scale({
      x: this.currentIndex === targetIndex ? 1.15 : 1,
      y: this.currentIndex === targetIndex ? 1.15 : 1
    })
    .animation({ duration: 200, curve: Curve.EaseInOut })
    .onClick(() => {
      // 拦截“我的”Tab点击：如果未登录，跳转登录页，不切换Tab
      if (targetIndex === 2 && !AuthService.checkLogin()) {
        buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGIN);
        return;
      }
      
      this.currentIndex = targetIndex;
      this.controller.changeIndex(targetIndex);
    })
  }

  aboutToAppear() {
    if (!this.entryHapRouter) {
      this.entryHapRouter = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.ENTRY_HAP, this.entryHapRouter);
    
    // // 测试 HttpUtil 的功能
    // this.testHttpUtil();


  };

  async testHttpUtil() {
    try {
      hilog.info(0x0000, 'TestHttp', '开始测试 HttpUtil...');
      // 测试URL
      const url = 'http://172.20.10.2:10020/record/service/click/record';

      
      const httpRequest = http.createHttp();
      const response = await httpRequest.request(url, { method: http.RequestMethod.GET });
      
      hilog.info(0x0000, 'TestHttp', `测试原生 HTTP 请求成功，状态码: ${response.responseCode}`);
      hilog.info(0x0000, 'TestHttp', `返回内容: ${typeof response.result === 'string' ? response.result.substring(0, 100) : '非文本数据'}...`);
      
      httpRequest.destroy();

      // ----------------------------------------------------
      // 如果你要测试封装好的 HttpUtil，需要有一个符合你们业务后端数据结构的真实接口
      // 例如：
      // const res = await HttpUtil.get<any>('你的真实后端接口/api/test');
      // hilog.info(0x0000, 'TestHttp', `HttpUtil 测试成功: ${JSON.stringify(res)}`);

    } catch (e) {
      const error = e as Error;
      hilog.error(0x0000, 'TestHttp', `测试请求失败: ${error.message}`);
    }
  }

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
    .navDestination(this.routerMap)
    .onAppear(() => {
      // 在 Tab 栏加载后，检查登录状态并跳转
      if (!AuthService.checkLogin()) {
        buildRouterModel(RouterNameConstants.ENTRY_HAP, BuilderNameConstants.LOGIN_LOGIN);
      }
    });
  }
}

