@isTest
private class Trigger_Order_AccountCA_Test {
    @isTest static void test_AccountCA_whenOrderActivated() {
        Integer nbAccount = 10;
        Integer nbOrder = 105;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = Test_DataFactory.createAccounts(nbAccount);
        List<Order> testOrders = Test_DataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
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
