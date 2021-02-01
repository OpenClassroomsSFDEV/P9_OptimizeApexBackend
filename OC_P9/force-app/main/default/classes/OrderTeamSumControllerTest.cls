@isTest
private with sharing class OrderTeamSumControllerTest {
    @TestSetup
    static void makeData(){
        Integer nbAccount = 10;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestDataFactory.createAccounts(nbAccount);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
        for (Order order : testOrders) {
            order.Status = 'Activated';
        }
        update testOrders;
    }

    @isTest static void test_sumOrder() {
        OrderTeamSumController controller = new OrderTeamSumController();
        Test.startTest();
        decimal ordersSum = controller.ordersSum;
        Test.stopTest();
        System.assertEquals(10 * 5 * 10 * 5, ordersSum, 'Montant total incorrect');
    }
}