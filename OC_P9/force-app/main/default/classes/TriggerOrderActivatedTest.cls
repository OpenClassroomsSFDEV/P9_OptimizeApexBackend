@isTest
private class TriggerOrderActivatedTest {
    @isTest static void test_AccountCA_isCorrect() {
        Integer nbAccount = 10;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestDataFactory.createAccounts(nbAccount);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
        for (Order order : testOrders) {
            order.Status = 'Activated';
        }

        Test.startTest();
        update testOrders;
        Test.stopTest();
        
        testAccounts = [SELECT Id, Chiffre_d_affaire__c
                                FROM Account
                                WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Activated')
                                ];
        System.assertEquals(nbAccount, testAccounts.size(), 'mauvais nombre de comptes');
        Integer expectedCA = nbOrder * price * quantity;
        for(Account account : testAccounts){
            System.assertEquals(expectedCA, account.Chiffre_d_affaire__c, 'CA incorrect');
        }
    }

}
