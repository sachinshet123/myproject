import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class DynamicObjectForm extends NavigationMixin(LightningElement) {
    selectedObject = '';
    objectOptions = [
        { 'label': 'Account', 'value': 'Account'}, 
        { 'label': 'Contact', 'value': 'Contact'}, 
        { 'label': 'Case', 'value': 'Case'},
        { 'label': 'Opportunity', 'value': 'Opportunity'}];

        handleObjectChange(event) {
            this.selectedObject = event.target.value;
            switch(this.selectedObject) {
                case 'Account':
                    this[NavigationMixin.Navigate]({type : 'standard__objectPage', attributes: {
                        objectApiName: 'Account',
                        actionName: 'new'
                    }});
                    break;
                default : 
                window.alert('no object selected');
            }
        }

}