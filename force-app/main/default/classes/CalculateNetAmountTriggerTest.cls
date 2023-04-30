// Définit la classe CalculateNetAmountTriggerTest comme une classe de test
// Cette annotation permet à Salesforce de reconnaître cette classe comme une classe de test
// et d'exécuter les méthodes de test à l'intérieur de cette classe
@isTest
public with sharing class CalculateNetAmountTriggerTest {

    // Définit une méthode de test statique nommée TestCalculateNetAmount
    @isTest
    static void testCalculateNetAmount() {
        
        // Crée une instance de compte fictif avec des commandes et des produits de commande associés
        // en utilisant la classe TestDataFactory
        Account acct = TestDataFactory.createOneAccountWithOrdsAndOrdProducts(1, 10000, 5, 5, 1000, 'Draft');
        
        // Encadre le code de test entre les méthodes startTest() et stopTest()
        // pour mesurer les limites de l'utilisation des ressources dans Salesforce
        Test.startTest();
        
        // Sélectionne toutes les commandes associées au compte fictif créé précédemment
        List<Order> ord = [Select Id, OrderNumber, AccountId, TotalAmount, Status, ShipmentCost__c, NetAmount__c, EffectiveDate from Order where AccountId = :acct.id];
        
        // Modifie le statut de la première commande sélectionnée en "Ordered"
        // en utilisant la méthode setOrderStatuToOrdered() de la classe TestDataFactory
        TestDataFactory.setOrderStatusToOrdered(ord,1);
        
        // Arrête la mesure des limites d'utilisation des ressources Salesforce
        Test.stopTest();
        
        // Sélectionne la première commande associée au compte fictif
        // pour vérifier si le champ NetAmount__c a été mis à jour
        Order od = [select TotalAmount,NetAmount__c from Order where AccountId = :acct.Id];
        
        // Vérifie que la valeur de NetAmount__c de la commande est égale à 1500
        // en utilisant la méthode assertEquals() de la classe System
        // Si cette condition est vraie, le test réussit. Sinon, le test échoue et une erreur est signalée.
        System.assertEquals(od.NetAmount__c, 1500, 'Result should be 1500');
    }
}