@isTest
private with sharing class UpdateAccountsScheduleableTest {

    @isTest 
    static void updateAccountScheduleableTest() {
        // Start of the test
        Test.startTest();
        
        // Running the scheduler in 1 minute
        String cronExp = '0 0 0/1 * * ?';
        String jobId = System.schedule('Update Accounts', cronExp, new UpdateAccountsScheduleable());
        
        // Retrieval of CronTrigger information corresponding to the job
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE Id = :jobId];
        
        // End of the test
        Test.stopTest();
        
        // Verification of results
        System.assertEquals(cronExp, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
    }
}