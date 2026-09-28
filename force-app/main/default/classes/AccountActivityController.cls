public with sharing class AccountActivityController {
    @AuraEnabled(cacheable=true)
    public static List<AccountActivityWrapper> getAccountActivities(Id accountId) {
        List<AccountActivityWrapper> activities = new List<AccountActivityWrapper>();

        List<Task> tasks = [
            SELECT Id, Subject, Status, ActivityDate, CreatedDate
            FROM Task
            WHERE WhoId IN (SELECT Id FROM Contact WHERE AccountId = :accountId)
            ORDER BY ActivityDate DESC
            LIMIT 10
        ];

        for (Task task : tasks) {
            activities.add(new AccountActivityWrapper(
                task.Id,
                task.Subject,
                task.Status,
                task.ActivityDate,
                task.CreatedDate
            ));
        }

        return activities;
    }

    public class AccountActivityWrapper {
        @AuraEnabled
        public Id taskId { get; set; }

        @AuraEnabled
        public String subject { get; set; }

        @AuraEnabled
        public String status { get; set; }

        @AuraEnabled
        public Date activityDate { get; set; }

        @AuraEnabled
        public DateTime createdDate { get; set; }

        public AccountActivityWrapper(Id taskId, String subject, String status, Date activityDate, DateTime createdDate) {
            this.taskId = taskId;
            this.subject = subject;
            this.status = status;
            this.activityDate = activityDate;
            this.createdDate = createdDate;
        }
    }
}
