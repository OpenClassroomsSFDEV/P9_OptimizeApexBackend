@isTest
private class UpdateAccountsTurnOverTest{

@isTest
static void updateAccountsTurnOverTestWithOneOrderAndMultipleOrderItem(){

// Créer un compte avec une commande ayant un statut "Brouillon" et une expédition de 100, ainsi que 5 OrderItem pour chaque commande ayant un prix unitaire de 200 et une quantité de 1
Account acct = TestDataFactory.createOneAccountWithOrdsAndOrdProducts(1, 1, 5, 1, 200,'Draft');  

Test.startTest();
// Sélectionner les commandes de l'Account créé
List<Order> ord = [Select Id, OrderNumber, AccountId, TotalAmount, Status, ShipmentCost__c, NetAmount__c, EffectiveDate
                from Order
                where AccountId =:acct.Id];

// Définit l'état de la commande sur "Ordered" pour activer le déclencheur
TestDataFactory.setOrderStatusToOrdered(ord, 1); 

Test.stopTest();

// Sélectionner l'Account et vérifier que le chiffre d'affaires a été correctement mis à jour
Account acc = [select Id, Name, Chiffre_d_affaire__c
            from Account
            where Id = :acct.Id];
System.assertEquals(acc.Chiffre_d_affaire__c, 1000,'Result should be 1000'); 

}

@isTest
static void testUpdateAccountTurnoverWithMultipleOrder(){

// Créer un compte avec 200 commandes ayant un statut "Brouillon" et une expédition de 100, ainsi qu'un OrderItem pour chaque commande ayant un prix unitaire de 10 et une quantité de 1
Account acct = TestDataFactory.createOneAccountWithOrdsAndOrdProducts(200, 100, 1, 1, 10,'Draft');

Test.startTest();

// Sélectionner les commandes de l'Account créé
List<Order> ords = [select Id, OrderNumber, AccountId, Status, ShipmentCost__c, NetAmount__c, EffectiveDate
                from Order
                where AccountId = :acct.Id];

// Définit l'état de la 20ème commande sur "Ordered" pour activer le déclencheur
TestDataFactory.setOrderStatusToOrdered(ords, 20); 

Test.stopTest();

// Sélectionner l'Account et vérifier que le chiffre d'affaires a été correctement mis à jour
Account acc = [select Id, Name, Chiffre_d_affaire__c
            from Account
            where Id = :acct.Id]; 
System.assertEquals(acc.Chiffre_d_affaire__c, 200,'Result should be 200'); 

}

}