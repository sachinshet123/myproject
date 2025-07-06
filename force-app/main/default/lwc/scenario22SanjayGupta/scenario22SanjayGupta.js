import { LightningElement, api } from 'lwc';
import { deleteRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import { NavigationMixin } from "lightning/navigation";
export default class Scenario22SanjayGupta extends NavigationMixin(LightningElement) {


   @api recordId;
   @api objectApiName;


   delete1(event) {
       this[NavigationMixin.Navigate]({
           type: "standard__objectPage",
           attributes: {
             objectApiName: "Contact",
             actionName: "list"


           },
           state: {      
               filterName: 'Recent'
           }
         });
        
       deleteRecord(this.recordId)
         .then(() => {
             console.log('record is deleted');
         })
         .catch((error) => {
           this.dispatchEvent(
             new ShowToastEvent({
               title: "Error deleting record",
               message: error.body.message,
               variant: "error"
             }),
           );
         });
     }
}