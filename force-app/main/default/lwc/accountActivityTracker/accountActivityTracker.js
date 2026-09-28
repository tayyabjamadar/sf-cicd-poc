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

    formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US');
    }

    getStatusClass(status) {
        const statusMap = {
            'Completed': 'slds-badge slds-badge_success',
            'In Progress': 'slds-badge slds-badge_info',
            'Not Started': 'slds-badge slds-badge_lightest'
        };
        return statusMap[status] || 'slds-badge';
    }
}
