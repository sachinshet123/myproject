import { LightningElement, api } from 'lwc';
import {deleteRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DeleteRecordUsingLDS extends LightningElement {
    @api recordId;
    handleDelete() {
        deleteRecord(this.recordId).then(
                () => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Record is deleted successfully',
                            variant: 'success',
                        }),
                    )
    }).catch(error => {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error while deleting record',
                message: error.body.message,
                variant: 'error',
            }),
        )
    })
}
}