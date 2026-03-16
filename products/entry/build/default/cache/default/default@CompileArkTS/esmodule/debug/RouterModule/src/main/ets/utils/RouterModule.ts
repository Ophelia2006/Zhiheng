import type { RouterModel } from '../model/RouterModel';
import Logger from "@bundle:com.example.zhiheng/entry@RouterModule/ets/utils/Logger";
export class RouterModule {
    static builderMap: Map<string, WrappedBuilder<[
        object
    ]>> = new Map<string, WrappedBuilder<[
        object
    ]>>();
    static routerMap: Map<string, NavPathStack> = new Map<string, NavPathStack>();
    // Registering a builder by name.
    public static registerBuilder(builderName: string, builder: WrappedBuilder<[
        object
    ]>): void {
        RouterModule.builderMap.set(builderName, builder);
    }
    // Get builder by name.
    public static getBuilder(builderName: string): WrappedBuilder<[
        object
    ]> {
        const builder = RouterModule.builderMap.get(builderName);
        if (!builder) {
            Logger.info('not found builder ' + builderName);
        }
        return builder as WrappedBuilder<[
            object
        ]>;
    }
    // Registering a router by name.
    public static createRouter(routerName: string, router: NavPathStack): void {
        RouterModule.routerMap.set(routerName, router);
    }
    // Get router by name.
    public static getRouter(routerName: string): NavPathStack {
        return RouterModule.routerMap.get(routerName) as NavPathStack;
    }
    // Jumping to a Specified Page by Obtaining the Page Stack.
    public static async push(router: RouterModel): Promise<void> {
        const harName = router.builderName.split('_')[0];
        // Dynamically import the page to be redirected to.
        await import(harName).then((ns: any): Promise<void> => ns.harInit(router.builderName));
        RouterModule.getRouter(router.routerName).pushPath({ name: router.builderName, param: router.param });
    }
    // Obtain the page stack and pop it.
    // 返回到上一个页面，并从页面栈弹出退出的页面
    public static pop(routerName: string): void {
        // Find the corresponding route stack for pop.
        RouterModule.getRouter(routerName).pop();
    }
    // Get the page stack and clear it.
    // 清空栈，返回首页
    public static clear(routerName: string): void {
        // Find the corresponding route stack for pop.
        RouterModule.getRouter(routerName).clear();
    }
    // Directly jump to the specified route.
    public static popToName(routerName: string, builderName: string): void {
        RouterModule.getRouter(routerName).popToName(builderName);
    }
}
