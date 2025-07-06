import { LightningElement, track } from 'lwc';

export default class TrackDemo extends LightningElement {
    firstName = '';
    lastName = '';
    email = '';

    withoutTrackObject = {};

    @track withTrackObject = {};

    handleFirstName(event) {
        this.firstName = event.target.value;
        this.withoutTrackObject.firstName = event.target.value;
        this.withTrackObject.firstName = event.target.value;
    }

    handleLastName(event) {
        this.lastName = event.target.value;
        this.withoutTrackObject.lastName = event.target.value;
        this.withTrackObject.lastName = event.target.value;
    }

    handleEmail(event) {
        this.email = event.target.value;
        this.withoutTrackObject.email = event.target.value;
        this.withTrackObject.email = event.target.value;
    }
}