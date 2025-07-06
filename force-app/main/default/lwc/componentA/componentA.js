import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import TEXT_MESSAGE_CHANNEL from '@salesforce/messageChannel/TextMessageChannel__c';

export default class MessageSender extends LightningElement {
    message = '';

    @wire(MessageContext)
    messageContext;

    handleInputChange(event) {
        this.message = event.target.value;
    }

    sendMessage() {
        if (this.message) {
            const payload = { messageText: this.message };
            publish(this.messageContext, TEXT_MESSAGE_CHANNEL, payload);
            this.message = ''; // Clear input after sending
        }
    }
}