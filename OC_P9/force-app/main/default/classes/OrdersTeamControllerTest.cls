@isTest
private with sharing class OrdersTeamControllerTest {
    @TestSetup
    static void makeData(){
        Integer nbAccount = 10;
        Integer nbOrder = 5;
        Integer price = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestDataFactory.createAccounts(nbAccount);
        List<Order> testOrders = TestDataFactory.createOrdersForAccounts(testAccounts, nbOrder, price, quantity);
    }

    @isTest static void test_sumOrders() {
        OrdersTeamController controller = new OrdersTeamController();
        Test.startTest();
        decimal ordersSum = controller.ordersSum;
        Test.stopTest();
        System.assertEquals(10 * 5 * 10 * 5, ordersSum, 'Montant total incorrect');
    }
}