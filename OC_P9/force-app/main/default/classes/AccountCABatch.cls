/**
 * Traitement par lot pour calculer le chiffre d'affaire des comptes
 * 
 */
global class AccountCABatch implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext info){
        // liste des comptes avec commandes actives
        return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')');
    }
    // calcul du chiffre d'affaire
    global void execute(Database.BatchableContext info, List<Account> accountsWithOrders){
        AccountService.calculateCA(accountsWithOrders);
    }  
    
    global void finish(Database.BatchableContext info){
    } 
}