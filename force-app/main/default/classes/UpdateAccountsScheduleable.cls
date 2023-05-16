global with sharing class UpdateAccountsScheduleable implements Schedulable{

    // Execute method which will be called by the scheduler
    global void execute(SchedulableContext ctx) {
        // Creating an instance of the UpdateAccountBatch class
        UpdateAccountBatch updateAccounts = new UpdateAccountBatch();
        // Performing update accounts using UpdateAccountBatch class as a batch
        Database.executeBatch(updateAccounts);
    }
}