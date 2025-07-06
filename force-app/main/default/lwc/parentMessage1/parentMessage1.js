import { LightningElement } from 'lwc';

export default class ParentMessage1 extends LightningElement {
    handleClick(){
        this.template.querySelector('p').innerText = 'The message is: Hello World';
    }
}