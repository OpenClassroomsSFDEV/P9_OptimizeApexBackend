public with sharing class UpdateAccountBatch implements Database.Batchable<sObject> {
    
    // Start() method that returns a QueryLocator to retrieve accounts with current orders
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([SELECT Id, Chiffre_d_affaire__c, (SELECT Id, AccountId, TotalAmount FROM Orders WHERE Status = 'Ordered') FROM Account]);
    }
    
    // Execute() method that calculates the revenue for each account in the scope list
    public void execute(Database.BatchableContext context, List<Account> accListWithOrders) {
        for(Account acc : accListWithOrders) {
            for(Order ordr : acc.orders) {
                if(ordr.AccountId == acc.Id) {
                    if(acc.Chiffre_d_affaire__c != null) {
                        acc.Chiffre_d_affaire__c += ordr.TotalAmount;
                    } else {
                        acc.Chiffre_d_affaire__c = ordr.TotalAmount;
                    }
                }
            }
        }

    // Update scope list to save revenue changes
        update accListWithOrders;
    }
    
    // Finish() method which is empty because it doesn't need to do anything after execution
    public void finish(Database.BatchableContext bc) {
    // Execute any post-processing operations
    System.debug(bc);
    }
}