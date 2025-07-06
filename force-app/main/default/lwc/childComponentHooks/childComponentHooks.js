import { LightningElement, api } from 'lwc';


export default class ChildComponentHooks extends LightningElement {


    count = 0;
    @api
    message = 'default';


    constructor() {
        super();
        console.log('Child constructor called');
        console.log(this.count);
        console.log(this.message);
        console.log(this.template.querySelector('lightning-button'));
    }


    connectedCallback() {
        console.log('Child connected callback called');
        console.log(this.count);
        console.log(this.message);
        console.log(this.template.querySelector('lightning-button'));
        let error = {
            code: 100,
            message: 'Error from child connected callback!'
        };
        throw error;
    }


    renderedCallback() {
        console.log('Child rendered callback called');
        console.log(this.template.querySelector('lightning-button'));
    }


    disconnectedCallback() {
        console.log('Child disconnected callback called');
    }


    errorCallback(error, stack) {
        console.log('Child error callback called, error = ' + JSON.stringify(error) + ', stack = ' + JSON.stringify(stack));
    }


    increaseCount() {
        this.dispatchEvent(new CustomEvent('increasecount', {
            detail: {
                message: 'Increased count to ' + (++this.count)
            }
        }));
    }
}