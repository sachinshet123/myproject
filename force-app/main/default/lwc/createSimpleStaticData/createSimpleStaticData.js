import Email from '@salesforce/schema/Contact.Email';
import { LightningElement } from 'lwc';

export default class CreateSimpleStaticData extends LightningElement {
    staticPersonalDate = [{
        id:1,
        name: 'sanket marathe',
        age : 20,
        city : 'Bankapur',
        phone : '9880',
        Email : 'sanketmarathe@gmail.com'
    }, {
        id:1,
        name: 'sanket marathe 2',
        age : 20-2,
        city : 'Bankapur 2',
        phone : '9880 - 2',
        Email : 'sanketmarathe@gmail.com - 2 '
    }];
}