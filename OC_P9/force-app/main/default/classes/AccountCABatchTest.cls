@isTest
private class AccountCABatchTest {
    @TestSetup
    static void makeData(){
        Integer nbAccount = 10;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestDataFactory.createAccounts(nbAccount);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
    }
    /**
     * test du calcul de chiffre d'affaire
     */
    @isTest static void test_batch_updatesCA() {

        Test.startTest();
        AccountCABatch obj = new AccountCABatch();
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


