@isTest
private with sharing class MyTeamOrdersControllerTest {

    // Test data creation method
    @TestSetup
    static void makeData(){

        // Generate accounts list
        List<Account> accountsList = TestDataFactory.generateAccountsList(10);
        // Generate product
        Product2 teeshirt = TestDataFactory.generateProduct();
        // Generate pricebook entry
        PricebookEntry pbe = TestDataFactory.generatePriceBookEntry(teeshirt);
        // Generate orders list
        List<Order> ordersList = TestDataFactory.generateOrdersList(pbe, accountsList, 10, 15);
        // Generate order items list
        OrderItem item = TestDataFactory.generateOrderItemsList(ordersList, pbe, 1);
    }

    // Test method to check team order total calculation with orders present
    @isTest
    private static void teamOrderTest() {

        // Arrange - update order status to 'Ordered'
        List<Order> ordersList = [SELECT Id, Status FROM ORDER];

        for(Order order : ordersList) {
            order.Status = 'Ordered'; 
        }

        update ordersList;

        // Act - call controller method to calculate team order total
        Test.startTest();
        MyTeamOrdersController teamResults = new MyTeamOrdersController();
        Test.stopTest();

        // Assert - check if expected and actual team order totals match
        Decimal expectedTeamResults;
        System.assertEquals(750.0, teamResults.SumOders);
    }

    // Test method to check team order total calculation with no orders present
    @isTest 
    private static void teamWithNoOrderTest() {

        // Act - call controller method to calculate team order total
        Test.startTest();
        MyTeamOrdersController teamResults = new MyTeamOrdersController();
        Test.stopTest();

        // Assert - check if expected and actual team order totals match (null)
        Decimal expectedTeamResults;
        System.assertEquals(null, teamResults.SumOders);
    }
}
