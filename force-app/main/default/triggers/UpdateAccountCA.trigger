// Déclencheur qui met à jour le chiffre d'affaire des comptes liés aux commandes mises à jour
trigger UpdateAccountTotalRevenue on Order (after update) {
    // Crée un ensemble pour stocker les ID des comptes déclencheurs
    set<id> ids=new set<id>();
    // Parcourt toutes les commandes déclencheuses
    for(order ord: trigger.new){
        // Ajoute l'ID du compte lié à la commande à l'ensemble
        ids.add(ord.AccountId);
    }
        
    // Crée une liste pour stocker les comptes qui doivent être mis à jour
    List<Account> accountsToUpdate=new List<Account>();
    // Récupère les comptes avec les ID spécifiés dans une map
    Map<ID, Account> acc = new Map<ID, Account>([select id,Chiffre_d_affaire__c from account where id in :ids]);
    // Récupère les résultats groupés de toutes les commandes avec le statut "Ordered" et liées aux comptes avec les ID spécifiés
    AggregateResult[] groupedResults = [SELECT AccountId,SUM(TotalAmount)amt FROM Order where AccountId in:ids and Status='Ordered' group by AccountId]; 

    // Parcourt tous les résultats groupés
    for(AggregateResult Results: groupedResults){
         // Récupère l'ID du compte correspondant au résultat actuel
         Id accountId =(id) Results.get('AccountId');         
         // Récupère le compte correspondant à l'ID actuel dans la map
         Account a=acc.get(accountId);        
         // Met à jour le champ Chiffre_d_affaire__c avec la valeur agrégée de toutes les commandes liées au compte
         a.Chiffre_d_affaire__c=integer.valueOf(Results.get('amt')); 
         // Ajoute le compte mis à jour à la liste des comptes à mettre à jour
         accountsToUpdate.add(a);
    } 
     // Affiche les comptes mis à jour dans la fenêtre Debug Log
     for(Account acct:accountsToUpdate){
        system.debug(acct);
    }
}