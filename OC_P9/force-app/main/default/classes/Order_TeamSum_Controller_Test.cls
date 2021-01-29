@isTest
private with sharing class Order_TeamSum_Controller_Test {
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

    @isTest static void test_sumOrders() {
        Order_TeamSum_Controller controller = new Order_TeamSum_Controller();
        Test.startTest();
        decimal ordersSum = controller.ordersSum;
        Test.stopTest();
        System.assertEquals(10 * 5 * 10 * 5, ordersSum, 'Montant total incorrect');
    }
}