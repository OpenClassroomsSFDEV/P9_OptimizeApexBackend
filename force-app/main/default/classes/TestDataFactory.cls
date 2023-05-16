// Cette classe est utilisée pour créer des données de test pour les tests de déclencheurs et de contrôleurs.
@isTest
public with sharing class TestDataFactory {

    /**
    * Method to generate Accounts
    * @param Integer : number of accounts to create
    * @return List<Account>
    */
    public static List<Account> generateAccountsList(Integer numberOfAccountsToCreate) {
        List<Account> accList = new List<Account>();
        for(Integer i = 0; i < numberOfAccountsToCreate; i++) {
            Account acc = new Account(Name = 'Test'+i);
            accList.add(acc);
        }
        insert accList;
        return accList;
    }
 
  /**
    * Method to generate a Pricebook
    * @return Pricebook2
    */
    public static Pricebook2 generatePricebook() {
        Pricebook2 fashaPriceBook = new Pricebook2(Name = 'Catalogue Fasha - Test',
                                                   Description = 'Pricebook for test', 
                                                   IsActive = true);
        insert fashaPriceBook;
        return fashaPriceBook;
    }

    /**
    * Method to generate generateProduct
    * @return Product2
    */
    public static Product2 generateProduct() {
        Product2 teeshirt = new Product2(Name = 'Teeshirt violet', Family = 'Haut',  IsActive = true);
        insert teeshirt;
        return teeshirt;
    }
     
   /**
    * Method to generate generatePriceBookEntry
    * @param Product2 : related product
    * @return PricebookEntry
    */
    public static PricebookEntry generatePriceBookEntry(Product2 product) {
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = 75,
            IsActive = true
        );
        insert pbe;
        return pbe;
    }
 
    /**
    * Method to generate Orders
    * @param PricebookEntry : related pricebook entry
    * @param List<Account> : list of Accounts
    * @param Integer : number of orders to create
    * @param Integer : shipment cost
    * @return List<Order>
    */
    public static List<Order> generateOrdersList(PricebookEntry pbe, List<Account> accList, Integer numberOfOrdersToCreate, Integer shipmentCost) {
        List<Order> ordersList = new List<Order>();
        List<Contract> contractsList = new List<Contract>();

        // Create contracts for each account in the list
        for (Account acc : accList) {
            Contract contract = new contract(
                AccountId = acc.id,
                Status = 'Draft',
                ContractTerm = 10
            );
            contractsList.add(contract);
        }
        insert contractsList;

        // Create orders with the given pricebook entry and shipment cost
        for(Integer i = 0; i < numberOfOrdersToCreate; i++){
            Order ordr = new Order(AccountId = accList[0].Id,
                                Status = 'Draft',
                                EffectiveDate = Date.today(),
                                Pricebook2Id = pbe.Pricebook2Id,
                                shipmentCost__c = shipmentCost);
            ordersList.add(ordr);
        }
        insert ordersList;
        return ordersList;
    }
    /**
    * Method to generate Order Items
    * @param List<Order> : list of Orders
    * @param PricebookEntry : a price book entry
    * @param Integer : quantity of items
    * @return OrderItem
    */
    public static OrderItem generateOrderItemsList(List<Order> ordersList, PricebookEntry pbe, Integer quantity) {

        // Create an empty list to store the OrderItems
        List<OrderItem> orderItemList = new List<OrderItem>();
    
        // Create a variable to store the last OrderItem that was created
        OrderItem itemToReturn;
    
        // Loop through the list of Orders
        for(Order o : ordersList) {
    
            // Create a new OrderItem with the Order's Id, the PricebookEntry's Id, the quantity, and the unit price
            itemToReturn = new OrderItem(OrderId = o.Id,
                                         PricebookEntryId = pbe.Id,
                                         Quantity = quantity,
                                         UnitPrice = pbe.UnitPrice);
    
            // Add the new OrderItem to the list of OrderItems
            orderItemList.add(itemToReturn);
        }
    
        // Insert all the OrderItems into the database
        insert orderItemList;
    
        // Update all the Orders in the list to ensure that the OrderItem records are associated with them
        update ordersList;
    
        // Return the last OrderItem that was created
        return itemToReturn;
    }
 }