import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import TEXT_MESSAGE_CHANNEL from '@salesforce/messageChannel/TextMessageChannel__c';

export default class MessageReceiver extends LightningElement {
    receivedMessage = 'No message received';

    @wire(MessageContext)
    messageContext;

    connectedCallback() {
        subscribe(this.messageContext, TEXT_MESSAGE_CHANNEL, (message) => {
            if (message?.messageText) {
                this.receivedMessage = message.messageText;
            }
        });
    }
}