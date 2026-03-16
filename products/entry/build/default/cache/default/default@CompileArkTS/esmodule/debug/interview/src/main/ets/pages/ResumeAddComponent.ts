if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ResumeAddComponent_Params {
    viewModel?: InterviewViewModel;
    inputText?: string;
    scroller?: Scroller;
}
import type { Message } from '../model/Message';
import { InterviewViewModel } from "@bundle:com.example.zhiheng/entry@interview/ets/ViewModel/InterviewViewModel";
export class ResumeAddComponent extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__viewModel = new ObservedPropertyObjectPU(new InterviewViewModel(), this, "viewModel");
        this.__inputText = new ObservedPropertySimplePU('', this, "inputText");
        this.scroller = new Scroller();
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ResumeAddComponent_Params) {
        if (params.viewModel !== undefined) {
            this.viewModel = params.viewModel;
        }
        if (params.inputText !== undefined) {
            this.inputText = params.inputText;
        }
        if (params.scroller !== undefined) {
            this.scroller = params.scroller;
        }
    }
    updateStateVars(params: ResumeAddComponent_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__viewModel.purgeDependencyOnElmtId(rmElmtId);
        this.__inputText.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__viewModel.aboutToBeDeleted();
        this.__inputText.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __viewModel: ObservedPropertyObjectPU<InterviewViewModel>;
    get viewModel() {
        return this.__viewModel.get();
    }
    set viewModel(newValue: InterviewViewModel) {
        this.__viewModel.set(newValue);
    }
    private __inputText: ObservedPropertySimplePU<string>;
    get inputText() {
        return this.__inputText.get();
    }
    set inputText(newValue: string) {
        this.__inputText.set(newValue);
    }
    private scroller: Scroller;
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.height('100%');
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 1. Header
            Row.create();
            // 1. Header
            Row.width('100%');
            // 1. Header
            Row.height(56);
            // 1. Header
            Row.padding({ left: 16, right: 16 });
            // 1. Header
            Row.backgroundColor(Color.Transparent);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Back Button
            Button.createWithChild({ type: ButtonType.Circle, stateEffect: false });
            // Back Button
            Button.backgroundColor(Color.White);
            // Back Button
            Button.width(40);
            // Back Button
            Button.height(40);
            // Back Button
            Button.onClick(() => {
                // this.pageStack.pop();
            });
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('<');
            Text.fontSize(20);
            Text.fontColor(Color.Black);
        }, Text);
        Text.pop();
        // Back Button
        Button.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // Title
            Text.create('Job Finder UX');
            // Title
            Text.fontSize(18);
            // Title
            Text.fontWeight(FontWeight.Bold);
            // Title
            Text.layoutWeight(1);
            // Title
            Text.textAlign(TextAlign.Center);
        }, Text);
        // Title
        Text.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // More Options (Placeholder)
            Button.createWithChild({ type: ButtonType.Circle, stateEffect: true });
            // More Options (Placeholder)
            Button.backgroundColor(Color.White);
            // More Options (Placeholder)
            Button.width(40);
            // More Options (Placeholder)
            Button.height(40);
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('...');
            Text.fontSize(20);
            Text.fontColor(Color.Black);
        }, Text);
        Text.pop();
        // More Options (Placeholder)
        Button.pop();
        // 1. Header
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // 2. Chat List
            List.create({ scroller: this.scroller, initialIndex: this.viewModel.messages.length - 1 });
            // 2. Chat List
            List.layoutWeight(1);
            // 2. Chat List
            List.width('100%');
        }, List);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const msg = _item;
                {
                    const itemCreation = (elmtId, isInitialRender) => {
                        ViewStackProcessor.StartGetAccessRecordingFor(elmtId);
                        ListItem.create(deepRenderFunction, true);
                        if (!isInitialRender) {
                            ListItem.pop();
                        }
                        ViewStackProcessor.StopGetAccessRecording();
                    };
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        ListItem.create(deepRenderFunction, true);
                    };
                    const deepRenderFunction = (elmtId, isInitialRender) => {
                        itemCreation(elmtId, isInitialRender);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Row.create();
                            Row.width('100%');
                            Row.padding({ left: 16, right: 16, top: 10, bottom: 10 });
                        }, Row);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            If.create();
                            if (msg.isUser) {
                                this.ifElseBranchUpdateFunction(0, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // User Message Bubble
                                        Row.create();
                                        // User Message Bubble
                                        Row.width('100%');
                                        // User Message Bubble
                                        Row.justifyContent(FlexAlign.End);
                                        // User Message Bubble
                                        Row.alignItems(VerticalAlign.Top);
                                    }, Row);
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // Message Content
                                        Column.create();
                                        // Message Content
                                        Column.backgroundColor({ "id": 33554467, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                        // Message Content
                                        Column.padding(16);
                                        // Message Content
                                        Column.borderRadius({ topLeft: 16, topRight: 0, bottomLeft: 16, bottomRight: 16 });
                                        // Message Content
                                        Column.layoutWeight(1);
                                        // Message Content
                                        Column.shadow({ radius: 5, color: { "id": 33554470, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" }, offsetX: 0, offsetY: 2 });
                                    }, Column);
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        Text.create(msg.content);
                                        Text.fontSize(16);
                                        Text.fontColor({ "id": 33554471, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                        Text.lineHeight(24);
                                    }, Text);
                                    Text.pop();
                                    // Message Content
                                    Column.pop();
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // User Avatar
                                        Image.create({ "id": 33554479, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                        // User Avatar
                                        Image.width(40);
                                        // User Avatar
                                        Image.aspectRatio(1);
                                        // User Avatar
                                        Image.borderRadius(90);
                                        // User Avatar
                                        Image.margin({ left: 10 });
                                    }, Image);
                                    // User Message Bubble
                                    Row.pop();
                                });
                            }
                            else {
                                this.ifElseBranchUpdateFunction(1, () => {
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // AI Message Bubble
                                        Column.create();
                                        // AI Message Bubble
                                        Column.alignItems(HorizontalAlign.Start);
                                        // AI Message Bubble
                                        Column.width('100%');
                                        // AI Message Bubble
                                        Column.borderRadius(10);
                                        // AI Message Bubble
                                        Column.backgroundColor({ "id": 33554468, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                    }, Column);
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // AI Avatar
                                        Image.create({ "id": 33554480, "type": 20000, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                        // AI Avatar
                                        Image.margin({ top: 10, left: 10 });
                                        // AI Avatar
                                        Image.aspectRatio(1);
                                        // AI Avatar
                                        Image.width(40);
                                        // AI Avatar
                                        Image.borderRadius(90);
                                    }, Image);
                                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                                        // Message Content
                                        Text.create(msg.content);
                                        // Message Content
                                        Text.fontSize(16);
                                        // Message Content
                                        Text.fontColor({ "id": 33554471, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
                                        // Message Content
                                        Text.lineHeight(24);
                                        // Message Content
                                        Text.margin(10);
                                    }, Text);
                                    // Message Content
                                    Text.pop();
                                    // AI Message Bubble
                                    Column.pop();
                                });
                            }
                        }, If);
                        If.pop();
                        Row.pop();
                        ListItem.pop();
                    };
                    this.observeComponentCreation2(itemCreation2, ListItem);
                    ListItem.pop();
                }
            };
            this.forEachUpdateFunction(elmtId, this.viewModel.messages, forEachItemGenFunction, (msg: Message) => msg.id, false, false);
        }, ForEach);
        ForEach.pop();
        // 2. Chat List
        List.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            // .backgroundColor($r('app.color.page_background'))
            // 3. Input Area
            Row.create();
            // .backgroundColor($r('app.color.page_background'))
            // 3. Input Area
            Row.width('100%');
            // .backgroundColor($r('app.color.page_background'))
            // 3. Input Area
            Row.padding({ left: 16, right: 16, top: 10, bottom: 10 });
            // .backgroundColor($r('app.color.page_background'))
            // 3. Input Area
            Row.backgroundColor(Color.Transparent);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            TextInput.create({ placeholder: '去回答...', text: this.inputText });
            TextInput.layoutWeight(1);
            TextInput.height(48);
            TextInput.borderRadius(24);
            TextInput.backgroundColor(Color.White);
            TextInput.padding({ left: 20, right: 20 });
            TextInput.onChange((value: string) => {
                this.inputText = value;
            });
            TextInput.onSubmit(() => {
                this.sendMessage();
            });
        }, TextInput);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Button.createWithChild({ type: ButtonType.Circle, stateEffect: true });
            Button.width(48);
            Button.height(48);
            Button.backgroundColor({ "id": 33554459, "type": 10001, params: [], "bundleName": "com.example.zhiheng", "moduleName": "entry" });
            Button.margin({ left: 12 });
            Button.onClick(() => {
                this.sendMessage();
            });
        }, Button);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('➤');
            Text.fontSize(20);
            Text.fontColor(Color.White);
        }, Text);
        Text.pop();
        Button.pop();
        // .backgroundColor($r('app.color.page_background'))
        // 3. Input Area
        Row.pop();
        Column.pop();
    }
    sendMessage() {
        if (this.inputText.trim() === '')
            return;
        // Add User Message
        const userMsg = this.viewModel.createUserMessage(this.inputText);
        this.viewModel.messages.push(userMsg);
        const prompt = this.inputText;
        this.inputText = ''; // Clear input
        // Scroll to bottom
        this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
        // Simulate AI Response
        setTimeout(() => {
            const aiMsg = this.viewModel.createAIMessage(`Simulated response to: "${prompt}"`);
            this.viewModel.messages.push(aiMsg);
            this.scroller.scrollToIndex(this.viewModel.messages.length - 1);
        }, 1000);
    }
    rerender() {
        this.updateDirtyElements();
    }
}
