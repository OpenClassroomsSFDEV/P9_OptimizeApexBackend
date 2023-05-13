public with sharing class UpdateAccountBatch implements Database.Batchable<sObject> {
    
    // Méthode start() qui renvoie un QueryLocator pour récupérer les comptes avec les commandes en cours
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, (SELECT Id, UnitPrice FROM OrderItems) FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = \'Ordered\')');
    }
    
    // Méthode execute() qui calcule le chiffre d'affaires pour chaque compte dans la liste de portée
    public void execute(Database.BatchableContext context, List<Account> scope) {
        for(Account acct : scope) {
            Decimal totalRevenue = 0;
            for(Order order : acct.Orders) {
                for(OrderItem item : order.OrderItems) {
                    totalRevenue += item.UnitPrice;
                }
            }
            acct.Chiffre_d_affaire__c = totalRevenue;
        }
        // Mettre à jour la liste de portée pour sauvegarder les modifications de chiffre d'affaires
        update scope;
    }
    
    // Méthode finish() qui est vide car elle n'a pas besoin de faire quelque chose après l'exécution
    public void finish(Database.BatchableContext context) {

    }
}