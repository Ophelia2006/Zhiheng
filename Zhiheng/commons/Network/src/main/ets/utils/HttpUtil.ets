import http from '@ohos.net.http';
import { AuthService } from '@ohos/auth';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

/**
 * 统一的网络请求响应接口
 */
export interface HttpResponse<T> {
  code: string; // 业务状态码，后端文档定义为 string
  message: string; // 提示信息
  token?: string; // JWT token，部分接口(如登录)在最外层返回
  data: T; // 实际的业务数据
  requestId: string; // 请求ID
  success: boolean; // 是否成功
}

/**
 * 封装底层的 HTTP 请求工具类
 * 统一处理 Token 注入、日志打印、通用错误拦截等
 */
export class HttpUtil {
  // 基础服务器地址（只保留 IP，不带端口）
  private static readonly BASE_HOST = 'http://192.168.0.107';
  // 连接与读取超时时间 (毫秒)
  private static readonly TIMEOUT = 10000;

  /**
   * 发起 HTTP 请求的底层核心方法
   */
  private static async request<T>(
    method: http.RequestMethod,
    url: string,
    data?: Object,
    queryParams?: Record<string, string | number | boolean>
  ): Promise<T> {
    hilog.debug(0, 'HttpUtil', 'request0')
    // 1. 构建完整的 URL
    // 如果外部传入的 url 已经是完整的 (以 http 开头)，则直接使用
    // 如果是相对路径 (如 /api/user...)，则默认加上 BASE_HOST，注意此时外部传入的 url 可能需要自带端口，比如 ':10020/api/...'
    let fullUrl = url.startsWith('http') ? url :
      `${HttpUtil.BASE_HOST}${url.startsWith(':') || url.startsWith('/') ? '' : '/'}${url}`;

    if (queryParams) {
      const queryString = Object.keys(queryParams)
        .map(key => `${encodeURIComponent(key)}=${encodeURIComponent(String(queryParams[key]))}`)
        .join('&');
      fullUrl += fullUrl.includes('?') ? `&${queryString}` : `?${queryString}`;
    }
    hilog.debug(0, 'HttpUtil', 'request1')

    // 2. 创建 HTTP 请求任务
    const httpRequest = http.createHttp();

    // 3. 构建请求头，统一注入 Token
    const headers: Record<string, string> = {
      'Content-Type': 'application/json'
    };
    hilog.debug(0, 'HttpUtil', 'request2')

    // 如果想要携带 JWT，我们需要从 AuthService 中获取当前用户的 token
    const user = AuthService.getUser();
    if (user && user.token) {
      // 在这把 Token 注入到 Authorization 请求头中，使用标准的 Bearer 格式
      headers['Authorization'] = `Bearer ${user.token}`;
    }
    // 添加 token 请求头，有些后端框架除了 Authorization 还可能校验小写的 token
    if (user && user.token) {
      headers['token'] = user.token;
    }

    // 4. 配置请求参数
    const options: http.HttpRequestOptions = {
      method: method,
      header: headers,
      readTimeout: HttpUtil.TIMEOUT,
      connectTimeout: HttpUtil.TIMEOUT,
      expectDataType: http.HttpDataType.STRING
    };

    if (data && (method === http.RequestMethod.POST || method === http.RequestMethod.PUT || method === http.RequestMethod.DELETE)) {
      options.extraData = JSON.stringify(data);
    }

    hilog.info(0x0000, 'HttpUtil', `Request [${method}] ${fullUrl}`);

    try {
      // 5. 发起真实请求
      const response = await httpRequest.request(fullUrl, options);

      // 6. 销毁请求任务
      httpRequest.destroy();

      // 7. 处理 HTTP 状态码
      if (response.responseCode >= 200 && response.responseCode < 300) {
        // HTTP 请求成功，解析业务数据
        const resultStr = response.result as string;
        // 这里断言为 T 是因为我们现在约定外部调用时，泛型 T 就是整个 HttpResponse 接口
        const resData = JSON.parse(resultStr) as T;

        // 由于 T 在这里是未知的（运行时被擦除），我们需要通过类型保护来安全地访问它的属性
        // 假设 T 至少包含了 HttpResponse 的基础结构
        const checkData = resData as Record<string, Object>;

        // 处理业务状态码
        if (checkData.success === true || checkData.code === "200" || checkData.code === "0" || checkData.code === "") {
          return resData; // 直接返回 T 类型，避免 unknown
        } else {
          // TODO: 未来如果后端支持了 401, 402 等业务错误码，可以在这里写针对性的拦截处理
          // 例如：
          // if (checkData.code === "401") {
          //   const context = getContext() as common.UIAbilityContext;
          //   AuthService.logout(context);
          //   hilog.error(0x0000, 'HttpUtil', 'Token expired or unauthorized');
          // }

          throw new Error((checkData.message as string) || '业务请求失败');
        }
      } else {
        // HTTP 状态码不正常（如 400, 401, 403, 404, 500 等）
        // TODO: 未来如果后端在 HTTP 状态码层面支持了 401（未授权），也可以在这里拦截处理
        // if (response.responseCode === 401) { ... }
        throw new Error(`HTTP 请求失败，状态码: ${response.responseCode}`);
      }
    } catch (err) {
      const error = err as Error;
      hilog.error(0x0000, 'HttpUtil', `Request failed: ${error.message}`);
      throw error;
    }
  }

  /**
   * 发起 GET 请求
   * @param url 请求路径
   * @param queryParams URL参数
   */
  public static get<T>(url: string, queryParams?: Record<string, string | number | boolean>): Promise<T> {
    return HttpUtil.request<T>(http.RequestMethod.GET, url, undefined, queryParams);
  }

  /**
   * 发起 POST 请求
   * @param url 请求路径
   * @param data 请求体
   */
  public static post<T>(url: string, data?: Object): Promise<T> {
    return HttpUtil.request<T>(http.RequestMethod.POST, url, data);
  }

  /**
   * 发起 PUT 请求
   * @param url 请求路径
   * @param data 请求体
   */
  static async put<T>(url: string, data?: Object): Promise<T> {
    return HttpUtil.request<T>(http.RequestMethod.PUT, url, data);
  }

  /**
   * 发起 DELETE 请求
   * @param url 请求路径
   */
  static async delete<T>(url: string, data?: Object): Promise<T> {
    return HttpUtil.request<T>(http.RequestMethod.DELETE, url, data);
  }
}