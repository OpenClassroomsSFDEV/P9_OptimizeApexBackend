@isTest
private class TriggerOrderNetAmountTest {
    @isTest static void test_netAmount_isCorrect() {
        Integer nbAccount = 1;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestDataFactory.createAccounts(nbAccount);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
        for(Order order : testOrders){
            order.ShipmentCost__c = 15;
        }
        
        Test.startTest();
        List<Database.SaveResult> results = Database.update(testOrders, false);
        Test.stopTest();

        for(Database.SaveResult result : results){
            System.assertEquals(true, result.isSuccess(), 'update must be successful');
            System.assertEquals(0, result.getErrors().size(), 'must get no error');
        }        
        testOrders = [SELECT NetAmount__c FROM Order];
        Integer netAmountExpected = 5 * 10 - 15;
        for(Order order : testOrders){
            System.assertEquals(netAmountExpected, order.NetAmount__c, 'NetAmount incorrect');
        }
    }
}