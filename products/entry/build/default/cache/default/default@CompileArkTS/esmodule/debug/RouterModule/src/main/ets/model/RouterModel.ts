import { RouterModule } from "@bundle:com.example.zhiheng/entry@RouterModule/ets/utils/RouterModule";
// Routing information.
export class RouterModel {
    // Route page alias, in the form：${bundleName}_${pageName}.
    builderName: string = "";
    // Routing Stack Name.
    routerName: string = "";
    // Parameters that need to be transferred to the page.
    param?: object = new Object();
}
// Create routing information and put it into the routing stack table.
// 创建新页面，并跳转到这个页面（将它置于页面栈顶）
export function buildRouterModel(routerName: string, builderName: string, param?: object) {
    let router: RouterModel = new RouterModel();
    router.builderName = builderName;
    router.routerName = routerName;
    router.param = param;
    RouterModule.push(router);
}
