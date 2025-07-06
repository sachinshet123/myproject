import { LightningElement, wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class ContactListPagination extends LightningElement {
    contacts = [];
    pageToken = null;
    nextPageToken = null;
    previousPageToken = null;

    @wire(getListUi, {
        objectApiName: CONTACT_OBJECT,
        listViewApiName: 'AllContacts',
        pageToken: '$pageToken',
        pageSize: 5
    })
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data.records.records;
            this.nextPageToken = data.records.nextPageToken;
            this.previousPageToken = data.records.previousPageToken;
        } else if (error) {
            console.error('Error fetching contacts:', error);
        }
    }

    handleNext() {
        if (this.nextPageToken) {
            this.pageToken = this.nextPageToken;
        }
    }

    handlePrevious() {
        if (this.previousPageToken) {
            this.pageToken = this.previousPageToken;
        }
    }
}