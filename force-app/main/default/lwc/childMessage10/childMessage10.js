import { LightningElement, api} from 'lwc';

export default class ChildMessage10 extends LightningElement {
    @api message = 'before';
    @api changeMessage() {
        this.message = 'after';
}
}