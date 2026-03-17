import { BuilderNameConstants, buildRouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { LengthMetrics } from '@kit.ArkUI';

class QnAItem {
  question: string = '';
  answer: string = '';
}

@Component
export struct ReportDetailComponent {
  // 模拟10道面试题数据
  private qnaList: QnAItem[] = [
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

  // 展开状态数组
  @State expandedStates: boolean[] = new Array(10).fill(false);

  build() {
    Scroll() {
      Column({ space: 20 }) {
        
        // 1. 顶部：面试总分 + 等级评价
        this.ScoreHeaderBuilder()

        // 2. 五维雷达图：可视化能力分析 (用 Canvas 绘制多边形模拟)
        this.RadarChartBuilder()

        // 3. 知识点：标签式展示
        this.KnowledgeTagsBuilder()

        // 4. 总结报告：详细分析段落
        this.SummaryReportBuilder()

        // 5. 建议：可操作的改进指南
        this.SuggestionsBuilder()

        // 6. 10道问答：可展开折叠的卡片
        this.QnAListBuilder()

      }
      .width('100%')
      .padding({ left: 20, right: 20, top: 20, bottom: 40 })
      .backgroundColor('#F5F7FA') // 浅灰背景，突出白色卡片
    }
    .width('100%')
    .height('100%')
    .scrollBar(BarState.Off)
  }

  // --- 1. 顶部：面试总分 + 等级评价 ---
  @Builder
  ScoreHeaderBuilder() {
    Column() {
      Text('综合评价: 优秀')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1EC18D')
        .margin({ bottom: 10 })
      
      Row({ space: 10 }) {
        Text('85')
          .fontSize(48)
          .fontWeight(FontWeight.Bolder)
          .fontColor('#333333')
        Text('分')
          .fontSize(16)
          .fontColor('#666666')
          .margin({ bottom: 8 })
      }
      .alignItems(VerticalAlign.Bottom)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .alignItems(HorizontalAlign.Center)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }

  // --- 2. 五维雷达图：可视化能力分析 ---
  @Builder
  RadarChartBuilder() {
    Column() {
      Text('能力雷达图')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 15 })

      // 使用 Stack 和 多边形 模拟一个简单的雷达图效果
      Stack({ alignContent: Alignment.Center }) {
        // 背景网格 (五边形)
        Polygon()
          .points([[100, 0], [195, 69], [158, 180], [42, 180], [5, 69]])
          .fill('#F0F9F6')
          .stroke('#D0EFE2')
          .strokeWidth(1)
          .width(200)
          .height(180)

        // 内层网格
        Polygon()
          .points([[100, 36], [157, 77], [135, 144], [65, 144], [43, 77]])
          .fill('transparent')
          .stroke('#D0EFE2')
          .strokeWidth(1)
          .width(200)
          .height(180)

        // 数据区域
        Polygon()
          .points([[100, 18], [176, 73], [146, 162], [53, 162], [24, 73]])
          .fill('#401EC18D') // 带透明度的绿色
          .stroke('#1EC18D')
          .strokeWidth(2)
          .width(200)
          .height(180)

        // 标签
        Text('基础知识').position({ x: 70, y: -20 }).fontSize(12).fontColor('#666')
        Text('深度理解').position({ x: 200, y: 60 }).fontSize(12).fontColor('#666')
        Text('拓展能力').position({ x: 160, y: 190 }).fontSize(12).fontColor('#666')
        Text('思维逻辑').position({ x: -10, y: 190 }).fontSize(12).fontColor('#666')
        Text('表达能力').position({ x: -30, y: 60 }).fontSize(12).fontColor('#666')
      }
      .width('100%')
      .height(220)
      .margin({ top: 10, bottom: 10 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }

  // --- 3. 知识点：标签式展示 ---
  @Builder
  KnowledgeTagsBuilder() {
    Column() {
      Text('核心知识点')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 15 })

      Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.vp(10), cross: LengthMetrics.vp(10) } }) {
        this.TagBuilder('Java基础', '#E6F9F0', '#1EC18D')
        this.TagBuilder('JVM调优', '#FFFBE6', '#FAAD14')
        this.TagBuilder('Spring Boot', '#E6F0FF', '#1890FF')
        this.TagBuilder('Redis缓存', '#FFF0F6', '#2F54EB')
        this.TagBuilder('MySQL索引', '#F9F0FF', '#EB2F96')
        this.TagBuilder('并发编程', '#E6F9F0', '#1EC18D')
      }
      .width('100%')
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  TagBuilder(text: string, bgColor: string, textColor: string) {
    Text(text)
      .fontSize(13)
      .fontColor(textColor)
      .backgroundColor(bgColor)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .borderRadius(16)
  }

  // --- 4. 总结报告：详细分析段落 ---
  @Builder
  SummaryReportBuilder() {
    Column() {
      Text('面试总结')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10 })

      Text('候选人基础扎实，对Java核心机制（如JVM、并发编程）有较深入的理解。在框架层面，熟悉Spring Boot的底层原理。数据库及缓存方面表现良好，能够准确回答索引结构及常见缓存问题。整体思维逻辑清晰，表达流畅。但在某些底层细节的拓展上（如分布式事务的实际落地案例）略显经验不足。')
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(22)
        .textAlign(TextAlign.Start)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }

  // --- 5. 建议：可操作的改进指南 ---
  @Builder
  SuggestionsBuilder() {
    Column() {
      Text('改进建议')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 10 })

      Column({ space: 10 }) {
        this.SuggestionItemBuilder('1. 增强实战经验：多参与或了解分布式系统下的高可用、高并发设计真实案例。')
        this.SuggestionItemBuilder('2. 深入源码：建议抽时间阅读Spring核心组件和Redis底层网络模型的源码。')
        this.SuggestionItemBuilder('3. 算法提升：虽然本次未重点考察算法，但大厂面试常有手撕代码环节，建议保持LeetCode的日常练习。')
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  SuggestionItemBuilder(text: string) {
    Row() {
      Text('•')
        .fontSize(14)
        .fontColor('#1EC18D')
        .fontWeight(FontWeight.Bold)
        .margin({ right: 8 })
      Text(text)
        .fontSize(14)
        .fontColor('#666666')
        .lineHeight(20)
        .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Top)
  }

  // --- 6. 10道问答：可展开折叠的卡片 ---
  @Builder
  QnAListBuilder() {
    Column() {
      Text('面试问答回顾')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .width('100%')
        .textAlign(TextAlign.Start)
        .margin({ bottom: 15 })

      ForEach(this.qnaList, (item: QnAItem, index: number) => {
        Column() {
          // 问题区域 (可点击)
          Row() {
            Text(`Q${index + 1}: ${item.question}`)
              .fontSize(15)
              .fontWeight(FontWeight.Medium)
              .fontColor('#333333')
              .layoutWeight(1)
            
            Text(this.expandedStates[index] ? '▲' : '▼')
              .fontSize(12)
              .fontColor('#999999')
              .margin({ left: 10 })
          }
          .width('100%')
          .padding(15)
          .backgroundColor('#F9F9F9')
          .borderRadius(this.expandedStates[index] ? { topLeft: 8, topRight: 8 } : 8)
          .onClick(() => {
            this.expandedStates[index] = !this.expandedStates[index];
          })

          // 回答区域 (展开时显示)
          if (this.expandedStates[index]) {
            Row() {
              Text(`AI反馈: ${item.answer}`)
                .fontSize(14)
                .fontColor('#666666')
                .lineHeight(20)
            }
            .width('100%')
            .padding(15)
            .backgroundColor('#FFFFFF')
            .border({ width: { bottom: 1, left: 1, right: 1 }, color: '#F0F0F0' })
            .borderRadius({ bottomLeft: 8, bottomRight: 8 })
          }
        }
        .width('100%')
        .margin({ bottom: 10 })
        // 添加展开动画
        .animation({ duration: 300, curve: Curve.EaseInOut })
      }, (item: QnAItem, index: number) => index.toString())
    }
    .width('100%')
    .padding(20)
    .backgroundColor('#FFFFFF')
    .borderRadius(30)
    .shadow({ radius: 10, color: '#0A000000', offsetX: 0, offsetY: 4 })
  }
}
