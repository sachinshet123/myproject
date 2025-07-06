import { LightningElement } from 'lwc';

export default class ShowObjectsPicklist extends LightningElement {
    
    selectedObject;
    objectOptions=[
        { label: 'Account', value: 'Account' },
        { label: 'Contact', value: 'Contact' },
        { label: 'Case', value: 'Case' },
        { label: 'Opportunity', value: 'Opportunity' }
       
    ];

}