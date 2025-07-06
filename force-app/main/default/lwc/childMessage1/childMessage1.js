import { LightningElement } from 'lwc';

export default class ChildMessage1 extends LightningElement {
    message = "hello";
    changeMessage(){
        this.message = "hello from child";
    }
}