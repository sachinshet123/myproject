import { LightningElement } from 'lwc';
import templateOne from './templateOne.html';
import templateTwo from './templateTwo.html';

export default class MiscMultipleTemplates extends LightningElement {
    flag = true;
    
    render() {
        return this.flag ? templateOne : templateTwo;
    }

    switchTemplate() {
        this.flag = !this.flag;
        // this.flag = (this.flag === true) ? false : true;
    }

    renderedCallback() {
        console.log('this is rendered callback');
    }
}