export enum MessageType {
    TEXT = 0,
    LIST = 1
}
export class Message {
    id: string;
    content: string;
    isUser: boolean; // true for User, false for AI
    type: MessageType;
    timestamp: number;
    constructor(id: string, content: string, isUser: boolean, type: MessageType = MessageType.TEXT) {
        this.id = id;
        this.content = content;
        this.isUser = isUser;
        this.type = type;
        this.timestamp = new Date().getTime();
    }
}
