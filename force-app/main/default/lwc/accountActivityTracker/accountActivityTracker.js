import { LightningElement, api, wire } from 'lwc';
import getAccountActivities from '@salesforce/apex/AccountActivityController.getAccountActivities';

export default class AccountActivityTracker extends LightningElement {
    @api recordId;
    activities = [];
    isLoading = false;
    error = null;

    @wire(getAccountActivities, { accountId: '$recordId' })
    wiredActivities({ error, data }) {
        this.isLoading = true;
        if (data) {
            this.activities = data;
            this.error = null;
        } else if (error) {
            this.error = error;
            this.activities = [];
        }
        this.isLoading = false;
    }

    get hasActivities() {
        return this.activities.length > 0;
    }

}
