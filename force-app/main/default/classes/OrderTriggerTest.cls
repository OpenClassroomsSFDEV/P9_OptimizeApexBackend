@isTest
private with sharing class OrderTriggerTest {
   
    // This method creates the data needed for testing
    @TestSetup
    static void makeData(){
        // Create a list of accounts
        List<Account> accList = TestDataFactory.generateAccountsList(1);

        // Create a product and a PricebookEntry from this product
        Product2 teeshirt = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(teeshirt);

        // Create an order list for the PricebookEntry and the given accounts
        // with a quantity of 10 and a delivery cost of 25
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accList, 10, 25);

        // Generate a list of command items for each command in the command list
        // and insert them into the database
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

     // This test verifies that the OrderTrigger.setOrderNetAmount trigger method calculates correctly
    // the net amount of the order and updates it in the Order object
    @isTest
    private static void setOrderNetAmountTest() {
        // Retrieve all orders from database
        List<Order> ordersList = [SELECT AccountId, Status, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order];
        List<Order> ordersToUpdate = new List<Order>();

        // Update the status of each order to 'Ordered' and add them to the list of orders to update
        Test.startTest();
        for(Order o : ordersList) {
            o.Status = 'Ordered';
            ordersToUpdate.add(o);
        }
        update ordersToUpdate;
        Test.stopTest();

        // Retrieve updated commands
        List<Order> ordersUpdated = [SELECT Id, TotalAmount, ShipmentCost__c, NetAmount__c FROM Order WHERE Status = 'Ordered'];
        
        // Check that the net amount of the first updated order is correct
        System.assertEquals(50, ordersUpdated[0].get('NetAmount__c'));
    }

      // This test verifies that the OrderTrigger.setAccountRevenuesUpdate trigger method calculates correctly
    // the total revenue for an account with 10 orders and updates the Account object with this value
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