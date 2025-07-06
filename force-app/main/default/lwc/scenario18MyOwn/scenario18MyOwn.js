import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'; // ✅ Import toast event

import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';


import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import ACCOUNTID_FIELD from '@salesforce/schema/Contact.AccountId';

export default class Scenario18MyOwn extends LightningElement {
    fields = [ACCOUNT_NAME_FIELD, PHONE_FIELD];
    objectAPIName = ACCOUNT_OBJECT;
    bool = false;
    accountId = '';

    handleAccountOnSuccess(event) {
        /*console.log('Record created with ID:', event.detail.id);
        
    
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Account created successfully! Record ID: ' + event.detail.id,
                variant: 'success'
            })
        );*/

        const record = event.detail.fields;
        console.log('record account name field' + record[ACCOUNT_NAME_FIELD]);
        console.log('this.fields' + this.fields);
        console.log('this.objectAPIName' + this.objectAPIName);

        this.bool = true;
        this.objectAPIName = CONTACT_OBJECT;
        this.accountId = event.detail.id;
        this.fields = [LAST_NAME_FIELD];
        

    }
}