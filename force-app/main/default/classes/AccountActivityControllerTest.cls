@IsTest
private class AccountActivityControllerTest {
    @TestSetup
    static void setupTestData() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(
            FirstName = 'Test',
            LastName = 'Contact',
            AccountId = testAccount.Id,
            Email = 'test@example.com'
        );
        insert testContact;

        Task testTask = new Task(
            Subject = 'Follow up call',
            Status = 'Not Started',
            ActivityDate = Date.today().addDays(7),
            WhoId = testContact.Id
        );
        insert testTask;
    }

    @IsTest
    static void testGetAccountActivities() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];

        Test.startTest();
        List<AccountActivityController.AccountActivityWrapper> activities =
            AccountActivityController.getAccountActivities(testAccount.Id);
        Test.stopTest();

        System.assertEquals(1, activities.size(), 'Should return one activity');
        System.assertEquals('Follow up call', activities[0].subject, 'Subject should match');
        System.assertEquals('Not Started', activities[0].status, 'Status should match');
    }

    @IsTest
    static void testGetAccountActivitiesEmpty() {
        Account emptyAccount = new Account(Name = 'Empty Account');
        insert emptyAccount;

        Test.startTest();
        List<AccountActivityController.AccountActivityWrapper> activities =
            AccountActivityController.getAccountActivities(emptyAccount.Id);
        Test.stopTest();

        System.assertEquals(0, activities.size(), 'Should return no activities');
    }

    @IsTest
    static void testAccountActivityWrapper() {
        Task testTask = [SELECT Id FROM Task LIMIT 1];
        Date testDate = Date.today();
        DateTime testDateTime = DateTime.now();

        AccountActivityController.AccountActivityWrapper wrapper =
            new AccountActivityController.AccountActivityWrapper(
                testTask.Id,
                'Test Task',
                'Completed',
                testDate,
                testDateTime
            );

        System.assertEquals('Test Task', wrapper.subject);
        System.assertEquals('Completed', wrapper.status);
        System.assertEquals(testDate, wrapper.activityDate);
    }

    @IsTest
    static void testAccountActivityWrapperStatusClasses() {
        Task testTask = [SELECT Id FROM Task LIMIT 1];
        Date testDate = Date.today();
        DateTime testDateTime = DateTime.now();

        AccountActivityController.AccountActivityWrapper inProgressWrapper =
            new AccountActivityController.AccountActivityWrapper(
                testTask.Id, 'In Progress Task', 'In Progress', testDate, testDateTime
            );
        System.assertEquals('slds-badge slds-badge_info', inProgressWrapper.statusClass);

        AccountActivityController.AccountActivityWrapper otherWrapper =
            new AccountActivityController.AccountActivityWrapper(
                testTask.Id, 'Other Task', 'Not Started', testDate, testDateTime
            );
        System.assertEquals('slds-badge', otherWrapper.statusClass);
    }
}
