import { api, LightningElement } from 'lwc';

export default class ChildComponentNew extends LightningElement {
    messageFromChild = '';
    messageFromChildAddEventListener = '';
    @api messageFromParent;
    handleKeyChange(event) {
        this.messageFromChild = event.target.value;
        const customEvent = new CustomEvent('passmessage', {
            detail : this.messageFromChild
        });
        this.dispatchEvent(customEvent);
    }
    
}