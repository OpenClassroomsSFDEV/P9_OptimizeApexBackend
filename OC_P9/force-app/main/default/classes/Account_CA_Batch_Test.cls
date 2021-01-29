@isTest
private class Account_CA_Batch_Test {
    @TestSetup
    static void makeData(){
        Integer nbAccount = 10;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = Test_DataFactory.createAccounts(nbAccount);
        List<Order> testOrders = Test_DataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
        for (Order order : testOrders) {
            order.Status = 'Activated';
        }
        update testOrders;
    }
    /**
     * test du calcul de chiffre d'affaire
     */
    @isTest static void test_batch_updatesCA() {

        Test.startTest();
        Account_CA_Batch obj = new Account_CA_Batch();
        Id batchId = DataBase.executeBatch(obj); 
        Test.stopTest();

        List<Account> results = [SELECT Id, Chiffre_d_affaire__c
                                FROM Account
                                WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Activated')
                                ];
        System.assertEquals(10, results.size(), 'mauvais nombre de comptes');
        for(Account account : results){
            System.assertEquals(5 * 5 * 10, account.Chiffre_d_affaire__c, 'CA incorrect');
        }
    }
}


