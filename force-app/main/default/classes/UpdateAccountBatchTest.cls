@isTest
private with sharing class UpdateAccountBatchTest {

    // Data setup for testing
    @TestSetup
    static void makeData(){
        // Generate a list of 200 accounts
        List<Account> accountsList = TestDataFactory.generateAccountsList(200);
        // Generate a product and a corresponding PricebookEntry
        Product2 teeshirt = TestDataFactory.generateProduct();
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(teeshirt);
        // Generate a list of 200 orders with 1 item each for generated accounts
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accountsList, 200, 10);
        // Generate an OrderItem for each order
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

    // Test for updating accounts
    @isTest
    static void testUpdate200Accounts() {
        
        // Retrieve list of orders
        List<Order> ordersList = [SELECT Id, Status FROM Order];

        // Update order status
        for(Order ordr : ordersList) {
            ordr.Status = 'Ordered';
        }
        update ordersList;

        // Start the test
        Test.startTest();

        // Instantiate the UpdateAccountBatch class for updating accounts in batch
        UpdateAccountBatch updateAccountsBatchTest = new UpdateAccountBatch();

        // Launch the batch and retrieve its Id
        Id batchId =  Database.executeBatch(updateAccountsBatchTest);

        // Launch the batch and retrieve its Id
        Test.stopTest();

        // Check that accounts have been updated
        List<Account> accountsUpdated = [SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status = 'Ordered')];  
        System.debug('accountsUpdated : '+ accountsUpdated[0].Chiffre_d_affaire__c);
        System.assertEquals(28000.0, accountsUpdated[0].Chiffre_d_affaire__c);

    }
}