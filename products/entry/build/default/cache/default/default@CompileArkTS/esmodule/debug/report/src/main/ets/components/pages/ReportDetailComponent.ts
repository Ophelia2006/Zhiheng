if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ReportDetailComponent_Params {
    qnaList?: QnAItem[];
    expandedStates?: boolean[];
}
import { LengthMetrics as LengthMetrics } from "@ohos:arkui.node";
class QnAItem {
    question: string = '';
    answer: string = '';
}
export class ReportDetailComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.qnaList = [
            { question: '请简述Java中的垃圾回收机制及常用算法？', answer: 'Java垃圾回收主要通过可达性分析算法判断对象是否存活。常用算法包括标记-清除、复制算法、标记-整理和分代收集。年轻代常使用复制算法，老年代多使用标记-整理。' } as QnAItem,
            { question: 'Spring Boot的自动装配原理是什么？', answer: '通过@SpringBootApplication注解下的@EnableAutoConfiguration实现。它借助SpringFactoriesLoader扫描META-INF/spring.factories文件，根据条件注解（如@ConditionalOnClass）决定是否将相关Bean注入Spring容器。' } as QnAItem,
            { question: '什么是Redis穿透、击穿和雪崩？如何解决？', answer: '穿透是查不到数据导致请求落到数据库（布隆过滤器）；击穿是热点Key过期导致瞬间高并发查数据库（互斥锁/热点数据永不过期）；雪崩是大量Key同时过期或Redis宕机（过期时间加随机值/集群高可用）。' } as QnAItem,
            { question: 'MySQL索引的底层数据结构是什么？为什么选它？', answer: '底层是B+树。B+树只有叶子节点存储数据，非叶子节点只存索引，树的高度低，磁盘I/O次数少；且叶子节点形成双向链表，极大地提高了范围查询的效率。' } as QnAItem,
            { question: '多线程下如何保证线程安全？', answer: '可以通过加锁（如synchronized、ReentrantLock）、使用并发集合（如ConcurrentHashMap）、使用原子类（AtomicInteger）、以及ThreadLocal等方式来保证。' } as QnAItem,
            { question: 'TCP的三次握手和四次挥手过程是怎样的？', answer: '三次握手：SYN -> SYN+ACK -> ACK，确保双方都能收发。四次挥手：FIN -> ACK -> FIN -> ACK，因为TCP是全双工的，双方需要各自关闭发送通道。' } as QnAItem,
            { question: '设计模式中，单例模式有哪些实现方式？', answer: '饿汉式（线程安全但可能浪费内存）、懒汉式（双重检查锁DCL保证线程安全）、静态内部类方式（推荐，延迟加载且线程安全）、枚举方式（防反射和反序列化破坏）。' } as QnAItem,
            { question: 'HTTP和HTTPS的区别？', answer: 'HTTPS在HTTP的基础上加入了SSL/TLS协议进行加密传输。HTTP是明文传输，端口80；HTTPS是密文传输，需要证书，端口443，更安全。' } as QnAItem,
            { question: '如何进行SQL查询优化？', answer: '避免SELECT *；合理使用索引，避免索引失效（如避免在索引列上运算、避免左模糊匹配）；使用LIMIT限制结果集；分析EXPLAIN执行计划。' } as QnAItem,
            { question: '什么是微服务架构？它有哪些优缺点？', answer: '将单一应用拆分为一组小的服务，每个服务运行在独立进程中，通过轻量级机制通信。优点：易于开发维护、独立部署、技术栈灵活。缺点：运维复杂、分布式事务和数据一致性处理困难。' } as QnAItem
        ];
        this.__expandedStates = new ObservedPropertyObjectPU(new Array(10).fill(false), this, "expandedStates");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ReportDetailComponent_Params) {
        if (params.qnaList !== undefined) {
            this.qnaList = params.qnaList;
        }
        if (params.expandedStates !== undefined) {
            this.expandedStates = params.expandedStates;
        }
    }
    updateStateVars(params: ReportDetailComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__expandedStates.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__expandedStates.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    // 模拟10道面试题数据
    private qnaList: QnAItem[];
    // 展开状态数组
    private __expandedStates: ObservedPropertyObjectPU<boolean[]>;
    get expandedStates() {
        return this.__expandedStates.get();
    }
    set expandedStates(newValue: boolean[]) {
        this.__expandedStates.set(newValue);
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Scroll.create();
            Scroll.width('100%');
            Scroll.height('100%');
            Scroll.scrollBar(BarState.Off);
        }, Scroll);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 20 });
            Column.width('100%');
            Column.padding({ left: 20, right: 20, top: 20, bottom: 40 });
            Column.backgroundColor('#F5F7FA');
        }, Column);
        // 1. 顶部：面试总分 + 等级评价
        this.ScoreHeaderBuilder.bind(this)();
        // 2. 五维雷达图：可视化能力分析 (用 Canvas 绘制多边形模拟)
        this.RadarChartBuilder.bind(this)();
        // 3. 知识点：标签式展示
        this.KnowledgeTagsBuilder.bind(this)();
        // 4. 总结报告：详细分析段落
        this.SummaryReportBuilder.bind(this)();
        // 5. 建议：可操作的改进指南
        this.SuggestionsBuilder.bind(this)();
        // 6. 10道问答：可展开折叠的卡片
        this.QnAListBuilder.bind(this)();
        Column.pop();
        Scroll.pop();
    }
    // --- 1. 顶部：面试总分 + 等级评价 ---
    ScoreHeaderBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.alignItems(HorizontalAlign.Center);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('综合评价: 优秀');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#1EC18D');
            Text.margin({ bottom: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create({ space: 10 });
            Row.alignItems(VerticalAlign.Bottom);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('85');
            Text.fontSize(48);
            Text.fontWeight(FontWeight.Bolder);
            Text.fontColor('#333333');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('分');
            Text.fontSize(16);
            Text.fontColor('#666666');
            Text.margin({ bottom: 8 });
        }, Text);
        Text.pop();
        Row.pop();
        Column.pop();
    }
    // --- 2. 五维雷达图：可视化能力分析 ---
    RadarChartBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('能力雷达图');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.margin({ bottom: 15 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
            Stack.create({ alignContent: Alignment.Center });
            // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
            Stack.width('100%');
            // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
            Stack.height(220);
            // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
            Stack.margin({ top: 10, bottom: 10 });
        }, Stack);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 背景网格 (五边形)
            Polygon.create();
            // 背景网格 (五边形)
            Polygon.points([[100, 0], [195, 69], [158, 180], [42, 180], [5, 69]]);
            // 背景网格 (五边形)
            Polygon.fill('#F0F9F6');
            // 背景网格 (五边形)
            Polygon.stroke('#D0EFE2');
            // 背景网格 (五边形)
            Polygon.strokeWidth(1);
            // 背景网格 (五边形)
            Polygon.width(200);
            // 背景网格 (五边形)
            Polygon.height(180);
        }, Polygon);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 内层网格
            Polygon.create();
            // 内层网格
            Polygon.points([[100, 36], [157, 77], [135, 144], [65, 144], [43, 77]]);
            // 内层网格
            Polygon.fill('transparent');
            // 内层网格
            Polygon.stroke('#D0EFE2');
            // 内层网格
            Polygon.strokeWidth(1);
            // 内层网格
            Polygon.width(200);
            // 内层网格
            Polygon.height(180);
        }, Polygon);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 数据区域
            Polygon.create();
            // 数据区域
            Polygon.points([[100, 18], [176, 73], [146, 162], [53, 162], [24, 73]]);
            // 数据区域
            Polygon.fill('#401EC18D');
            // 数据区域
            Polygon.stroke('#1EC18D');
            // 数据区域
            Polygon.strokeWidth(2);
            // 数据区域
            Polygon.width(200);
            // 数据区域
            Polygon.height(180);
        }, Polygon);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 标签
            Text.create('基础知识');
            // 标签
            Text.position({ x: 70, y: -20 });
            // 标签
            Text.fontSize(12);
            // 标签
            Text.fontColor('#666');
        }, Text);
        // 标签
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('深度理解');
            Text.position({ x: 200, y: 60 });
            Text.fontSize(12);
            Text.fontColor('#666');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('拓展能力');
            Text.position({ x: 160, y: 190 });
            Text.fontSize(12);
            Text.fontColor('#666');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('思维逻辑');
            Text.position({ x: -10, y: 190 });
            Text.fontSize(12);
            Text.fontColor('#666');
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('表达能力');
            Text.position({ x: -30, y: 60 });
            Text.fontSize(12);
            Text.fontColor('#666');
        }, Text);
        Text.pop();
        // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
        Stack.pop();
        Column.pop();
    }
    // --- 3. 知识点：标签式展示 ---
    KnowledgeTagsBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('核心知识点');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.margin({ bottom: 15 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } });
            Flex.width('100%');
        }, Flex);
        this.TagBuilder.bind(this)('Java基础', '#E6F9F0', '#1EC18D');
        this.TagBuilder.bind(this)('JVM调优', '#FFFBE6', '#FAAD14');
        this.TagBuilder.bind(this)('Spring Boot', '#E6F0FF', '#1890FF');
        this.TagBuilder.bind(this)('Redis缓存', '#FFF0F6', '#2F54EB');
        this.TagBuilder.bind(this)('MySQL索引', '#F9F0FF', '#EB2F96');
        this.TagBuilder.bind(this)('并发编程', '#E6F9F0', '#1EC18D');
        Flex.pop();
        Column.pop();
    }
    TagBuilder(text: string, bgColor: string, textColor: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(text);
            Text.fontSize(13);
            Text.fontColor(textColor);
            Text.backgroundColor(bgColor);
            Text.padding({ left: 12, right: 12, top: 6, bottom: 6 });
            Text.borderRadius(16);
        }, Text);
        Text.pop();
    }
    // --- 4. 总结报告：详细分析段落 ---
    SummaryReportBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('面试总结');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.margin({ bottom: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('候选人基础扎实，对Java核心机制（如JVM、并发编程）有较深入的理解。在框架层面，熟悉Spring Boot的底层原理。数据库及缓存方面表现良好，能够准确回答索引结构及常见缓存问题。整体思维逻辑清晰，表达流畅。但在某些底层细节的拓展上（如分布式事务的实际落地案例）略显经验不足。');
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.lineHeight(22);
            Text.textAlign(TextAlign.Start);
        }, Text);
        Text.pop();
        Column.pop();
    }
    // --- 5. 建议：可操作的改进指南 ---
    SuggestionsBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('改进建议');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.margin({ bottom: 10 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create({ space: 10 });
            Column.width('100%');
            Column.alignItems(HorizontalAlign.Start);
        }, Column);
        this.SuggestionItemBuilder.bind(this)('1. 增强实战经验：多参与或了解分布式系统下的高可用、高并发设计真实案例。');
        this.SuggestionItemBuilder.bind(this)('2. 深入源码：建议抽时间阅读Spring核心组件和Redis底层网络模型的源码。');
        this.SuggestionItemBuilder.bind(this)('3. 算法提升：虽然本次未重点考察算法，但大厂面试常有手撕代码环节，建议保持LeetCode的日常练习。');
        Column.pop();
        Column.pop();
    }
    SuggestionItemBuilder(text: string, parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.alignItems(VerticalAlign.Top);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('•');
            Text.fontSize(14);
            Text.fontColor('#1EC18D');
            Text.fontWeight(FontWeight.Bold);
            Text.margin({ right: 8 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create(text);
            Text.fontSize(14);
            Text.fontColor('#666666');
            Text.lineHeight(20);
            Text.layoutWeight(1);
        }, Text);
        Text.pop();
        Row.pop();
    }
    // --- 6. 10道问答：可展开折叠的卡片 ---
    QnAListBuilder(parent = null) {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.padding(20);
            Column.backgroundColor('#FFFFFF');
            Column.borderRadius(16);
            Column.shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('面试问答回顾');
            Text.fontSize(18);
            Text.fontWeight(FontWeight.Bold);
            Text.fontColor('#333333');
            Text.width('100%');
            Text.textAlign(TextAlign.Start);
            Text.margin({ bottom: 15 });
        }, Text);
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = (_item, index: number) => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Context.animation({ duration: 300, curve: Curve.EaseInOut });
                    Column.width('100%');
                    Column.margin({ bottom: 10 });
                    Context.animation(null);
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    // 问题区域 (可点击)
                    Row.create();
                    // 问题区域 (可点击)
                    Row.width('100%');
                    // 问题区域 (可点击)
                    Row.padding(15);
                    // 问题区域 (可点击)
                    Row.backgroundColor('#F9F9F9');
                    // 问题区域 (可点击)
                    Row.borderRadius(this.expandedStates[index] ? { topLeft: 8, topRight: 8 } : 8);
                    // 问题区域 (可点击)
                    Row.onClick(() => {
                        this.expandedStates[index] = !this.expandedStates[index];
                    });
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(`Q${index + 1}: ${item.question}`);
                    Text.fontSize(15);
                    Text.fontWeight(FontWeight.Medium);
                    Text.fontColor('#333333');
                    Text.layoutWeight(1);
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(this.expandedStates[index] ? '▲' : '▼');
                    Text.fontSize(12);
                    Text.fontColor('#999999');
                    Text.margin({ left: 10 });
                }, Text);
                Text.pop();
                // 问题区域 (可点击)
                Row.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    If.create();
                    // 回答区域 (展开时显示)
                    if (this.expandedStates[index]) {
                        this.ifElseBranchUpdateFunction(0, () => {
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Row.create();
                                Row.width('100%');
                                Row.padding(15);
                                Row.backgroundColor('#FFFFFF');
                                Row.border({ width: { bottom: 1, left: 1, right: 1 }, color: '#F0F0F0' });
                                Row.borderRadius({ bottomLeft: 8, bottomRight: 8 });
                            }, Row);
                            this.observeComponentCreation2((elmtId, isInitialRender) => {
                                Text.create(`AI反馈: ${item.answer}`);
                                Text.fontSize(14);
                                Text.fontColor('#666666');
                                Text.lineHeight(20);
                            }, Text);
                            Text.pop();
                            Row.pop();
                        });
                    }
                    else {
                        this.ifElseBranchUpdateFunction(1, () => {
                        });
                    }
                }, If);
                If.pop();
                Column.pop();
            };
            this.forEachUpdateFunction(elmtId, this.qnaList, forEachItemGenFunction, (item: QnAItem, index: number) => index.toString(), true, true);
        }, ForEach);
        ForEach.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}
