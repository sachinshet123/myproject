import { LightningElement, api } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";

export default class DeleteRecordDemo extends NavigationMixin(LightningElement) {
    @api recordId;

    handleDelete() {
        deleteRecord(this.recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted successfully',
                        variant: 'success'
                    })
                );

                // Navigate after successful deletion
                this[NavigationMixin.Navigate]({
                    type: "standard__objectPage",
                    attributes: {
                        objectApiName: "Account",
                        actionName: "list"
                    },
                    state: {
                        filterName: 'Recent'
                    }
                });
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}