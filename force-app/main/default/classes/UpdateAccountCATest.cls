@isTest
public with sharing class UpdateAccountCATest {

// Test pour la mise à jour des comptes
@isTest
static void testUpdateAccountCA() {
    
    // Créer plusieurs comptes avec des commandes et des produits de commande
    Account[] accts = TestDataFactory.createMultipleAccountWithOrdsAndOrdProducts(5, 3, 50, 5, 5, 500, 'Draft');
    
    // Début du test
    Test.startTest();
    
    // Instancier la classe de mise à jour des comptes
    UpdateAccountBatch uca = new UpdateAccountBatch();
    
    // Exécuter le lot de mise à jour
    Id batchId = Database.executeBatch(uca);
    
    // Fin du test
    Test.stopTest();
    
    // Vérifier que les comptes ont été mis à jour avec le chiffre d'affaires correct
    List<Account> acctsUpdated = [SELECT Id, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];
    for (Account acct : acctsUpdated){
        System.assertEquals(250000, acct.Chiffre_d_affaire__c, 'Result should be 250000');
    }
}
}