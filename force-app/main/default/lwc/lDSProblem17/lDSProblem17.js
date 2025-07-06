import { LightningElement, api, track } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';

export default class LDSProblem17 extends LightningElement {
    @api selectedId = null;
    @track fields = []; // Use @track for reactivity

    // Object selection dropdown options
    objectOptions = [{ label: 'Account', value: 'Account' }];

    // Handle object selection change
    handleObjectChange(event) {
        this.selectedId = event.detail.value;
        console.log('Selected Object:', this.selectedId);

        // Switch based on selected object
        switch (this.selectedId) {  // ✅ Fixed incorrect variable name
            case 'Account':
                this.fields = [NAME_FIELD]; // ✅ Assign the correct field
                break;
            default:
                this.fields = []; // Default case: Clear fields
        }
    }
}