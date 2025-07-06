import { LightningElement,api,track} from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class CreateContactRecordQuickAction5 extends LightningElement {
  closeFormaftercreation=true;    
  firstName='';
  lastName='';
  emailId='';
  @api recordId;
    contactChangeVal(event){
        if(event.target.label=='First Name'){
            this.firstName=event.target.value;
        }
        if(event.target.label=='Last Name'){
            this.lastName=event.target.value;
        }
        if(event.target.label=='Email'){
            this.emailId=event.target.value;
        }
    }
   insertContactRecord(){
            const fields={
            AccountId: this.recordId,
            FirstName: this.firstName,
            LastName: this.lastName,
            Email: this.emailId
            };
            const recordInput = {apiName: CONTACT_OBJECT.objectApiName, fields }
            createRecord(recordInput)
            .then(result => {
                this.contactId=result.id;
                console.log('Contact created with ID:', result.id);
                 // Show a success toast
                const toastEvent = new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact created successfully',
                    variant: 'success'
                });
                  this.dispatchEvent(toastEvent);
            })
                .catch(error => {
                    console.error('Error creating Contact:', error);
                   // Show an error toast
                const toastEvent = new ShowToastEvent({
                    title: 'Error',
                    message: 'Error creating contact: ' + error.body.message,
                    variant: 'error'
                });
                this.dispatchEvent(toastEvent);
            });
       
this.closeFormaftercreation=false;
       
    }  
}