import { LightningElement, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import userId from '@salesforce/user/Id';
import NAME_FIELD from '@salesforce/schema/User.Name';
import LAST_NAME_FIELD from '@salesforce/schema/User.LastName';
import USERNAME_FIELD from '@salesforce/schema/User.Username';


export default class GetCurrentUserInformation extends LightningElement {
    userId = userId;
    firstName = '';
    lastName = '';
    userName = '';

    @wire(getRecord, { recordId: '$userId', fields: [NAME_FIELD, LAST_NAME_FIELD, USERNAME_FIELD] }) 
    wiredRecord({error, data}) {
        if (data) {
            this.firstName = data.fields.Name.value; 
            this.lastName = data.fields.LastName.value;
            this.userName = data.fields.Username.value;
            console.log('name field ' + JSON.stringify(NAME_FIELD));
            console.log('last name field ' + LAST_NAME_FIELD);
            console.log('user name field ' + USERNAME_FIELD);
        }
        else if (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body.message,
                    variant: 'error'
                })
            )
        }
    }
}