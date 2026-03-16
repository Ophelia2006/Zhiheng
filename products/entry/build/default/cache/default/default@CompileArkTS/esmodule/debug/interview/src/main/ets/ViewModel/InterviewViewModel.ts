import { Message, MessageType } from "@bundle:com.example.zhiheng/entry@interview/ets/model/Message";
@Observed
export class InterviewViewModel {
    // Use @Observed object or simple array. In ArkTS, array changes might not trigger UI update if not using @State properly in Component.
    // We will manage the state in the component for simplicity or use a class that holds the array.
    // To make it truly MVVM with reactivity, we usually return the data and let the Component hold the @State.
    // However, let's try to keep logic here.
    messages: Message[] = [];
    constructor() {
        this.loadInitialMessages();
    }
    loadInitialMessages() {
        this.messages = [
            new Message('1', 'Analyze UX for Job Finder app', true, MessageType.TEXT),
            new Message('2', 'Key aspects of a job finder app\'s UX analysis:\n1. Seamless onboarding process\n2. Intuitive search and filtering\n3. Clear and organized job listings\n4. Personalized job recommendations\n5. Easy application process\n6. Communication and collaboration features\n7. User feedback and support options\n8. Accessibility considerations\n9. Performance and speed\n10. Visual design and branding consistency.', false, MessageType.TEXT),
            new Message('3', 'Onboarding copy for it', true, MessageType.TEXT),
            new Message('4', '周末踏春计划来咯!我为你精选了三个超有"时令感"和"松弛感"的宝藏去处，保证让你偷得浮生半日闲~\n' +
                '1.蓝田华胥镇杏花谷-山野秘境寻春踪\n' +
                '藏在秦岭脚下的万亩杏林，如雪海般铺满山野，花期正值盛放期顶端新闻 。这里人少花多，杏树自然生长，没有商业开发痕迹，只有花瓣随风飘落的静谧之美。建议步行进谷，感受泥土芬芳与花香交融，还能听村民讲女娲故里的古老故事，超有春日仪式感。', false, MessageType.TEXT)
        ];
    }
    // Returns the new message to be added to the state in UI
    createUserMessage(content: string): Message {
        return new Message(Date.now().toString(), content, true);
    }
    createAIMessage(content: string): Message {
        return new Message((Date.now() + 1).toString(), content, false);
    }
}
