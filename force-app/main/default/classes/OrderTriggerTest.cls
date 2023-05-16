@isTest
private with sharing class OrderTriggerTest {
   
    // Cette méthode crée les données nécessaires pour les tests
    @TestSetup
    static void makeData(){
        // Créer une liste de comptes
        List<Account> accList = TestDataFactory.generateAccountsList(1);

        // Créer un produit et un PricebookEntry à partir de ce produit
        Product2 teeshirt = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(teeshirt);

        // Créer une liste de commandes pour le PricebookEntry et les comptes donnés
        // avec une quantité de 10 et un coût de livraison de 25
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accList, 10, 25);

        // Générer une liste d'éléments de commande pour chaque commande de la liste de commandes
        // et les insérer dans la base de données
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

     // Ce test vérifie que la méthode de déclenchement OrderTrigger.setOrderNetAmount calcule correctement
    // le montant net de la commande et le met à jour dans l'objet Order
    @isTest
    private static void setOrderNetAmountTest() {
        // Récupérer toutes les commandes de la base de données
        List<Order> ordersList = [SELECT AccountId, Status, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];
        List<Order> ordersToUpdate = new List<Order>();

        // Mettre à jour le statut de chaque commande en 'Ordered' et les ajouter à la liste d'ordres à mettre à jour
        Test.startTest();
        for(Order o : ordersList) {
            o.Status = 'Ordered';
            ordersToUpdate.add(o);
        }
        update ordersToUpdate;
        Test.stopTest();

        // Récupérer les commandes mises à jour
        List<Order> ordersUpdated = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order WHERE Status = 'Ordered'];
        
        // Vérifier que le montant net de la première commande mise à jour est correct
        System.assertEquals(50, ordersUpdated[0].get('NetAmount__c'));
    }

      // Ce test vérifie que la méthode de déclenchement OrderTrigger.setAccountRevenuesUpdate calcule correctement
    // le chiffre d'affaires total pour un compte ayant 10 commandes et met à jour l'objet Account avec cette valeur
    @isTest
    private static void setAccountRevenuesUpdateTestWith10Orders() {

        // Retrieve all orders from the database and add them to the list of orders to update
        List<Order> ordersList = [SELECT AccountId, Status, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];
        List<Order> ordersToUpdate = new List<Order>();

        // Retrieve a random account from the database and update it with an initial turnover of 0
        Test.startTest();
        Account accountToAppendOrder = [SELECT Id, Chiffre_d_affaire__c FROM Account LIMIT 1];
        for(Order o : ordersList) {
            o.Status = 'Ordered';
            ordersToUpdate.add(o);
        }
        update ordersToUpdate;
        Test.stopTest();

        // Verify that the updated account's revenue value is equal to 500
        List<Account> accts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id = :accountToAppendOrder.Id];
        System.assertEquals(500, accts[0].Chiffre_d_affaire__c);
    }

    @isTest
    private static void setAccountRevenuesUpdateTestWith125Orders() {

    // Creates a list of orders to update their status
    List<Order> ordersToUpdate = new List<Order>();

    // Retrieves a list of accounts with their  Chiffre_d_affaire__c
    List<Account> accList = [SELECT Id, Chiffre_d_affaire__c FROM Account];
    System.debug(accList);

    // Generates a product, a PricebookEntry, a list of 125 orders and an associated item
    Product2 teeshirt = TestDataFactory.generateProduct();
    PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(teeshirt);
    List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accList, 125, 25);
    OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);

    // Updates the status of orders and adds them to the ordersToUpdate list
    Test.startTest();
    for(Order o : ordersList) {
        o.Status = 'Ordered';
        ordersToUpdate.add(o);
    }
    System.debug(ordersToUpdate.size());
    update ordersToUpdate;
    Test.stopTest();

    // Checks that the turnover of the account associated with the order has been updated
    List<Account> accts = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :accList];
    System.assertEquals(6250, accts[0].Chiffre_d_affaire__c);
    }
}