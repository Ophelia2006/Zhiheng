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
import { BuilderNameConstants } from '@ohos/routermodule';
export {PersonalPage}from './src/main/ets/pages/PersonalPage'
export {ProfileComponent as ProfilePage} from './src/main/ets/pages/ProfileComponent'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.MINE_PROFILE:
      import("./src/main/ets/pages/ProfilePage");
      break;
    case BuilderNameConstants.MINE_ACCOUNT:
      import("./src/main/ets/pages/AccountPage");
      break;
    default:
      break;
  }
}