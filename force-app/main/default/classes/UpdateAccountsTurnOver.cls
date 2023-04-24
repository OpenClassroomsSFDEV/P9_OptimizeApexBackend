global class UpdateAccountsTurnOver implements Database.Batchable<sObject>{
    
   global Database.QueryLocator start(Database.BatchableContext info){ 
//Requeter seulement les comptes qui ont au moins une commande avec le Status 'Ordered'
       return Database.getQueryLocator([SELECT Id, Name, (select Id, TotalAmount, OrderNumber, status from Orders) FROM Account WHERE Id IN(SELECT AccountId FROM Order WHERE Status = 'Ordered')]);

   }
// pour chaque compte, mise à jour du Chiffre d'affaire
   global void execute(Database.BatchableContext info, List<Account> scope){ 

// Récupérer la liste des comptes et des commandes enregistrées dans la méthode 
        List<Account> acctsToUpdate = new List<Account>();
        List<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order where status ='Ordered' AND AccountId IN:scope];
       
		for(Account acct:scope){

// Réinitialiser le Chiffre d'affaire avant la mise à jour
			acct.Chiffre_d_affaire__c = 0;

// Parcourir la liste des commandes associées au compte actuel et calculer le Chiffre d'affaire total
           for(order ord:listOrders){
               if(ord.AccountId ==acct.Id){
                   acct.Chiffre_d_affaire__c += ord.TotalAmount;
               }
           }

// Mettre à jour le compte dans la base de données
           acctsToUpdate.add(acct);
       }
       if(acctsToUpdate.isEmpty()){
        system.debug('No Account has any orders Ordered');
    } else {
        update acctsToUpdate;
        system.debug('Batch executed');
    }
    }       
   global void finish(Database.BatchableContext info){

// Afficher un message de fin de traitement
    system.debug('Batch finished');
    }
}