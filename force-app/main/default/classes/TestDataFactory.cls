@isTest
public with sharing class TestDataFactory {
    
    // Cette fonction retourne un compte et reçoit en paramètres le nombre de commandes, de produits de commande, la quantité de chaque produit de commande, le statut de chaque commande, le coût d'expédition de commande et les insère dans la base de données
    public static Account createOneAccountWithOrdsAndOrdProducts(Integer numOrders, Integer orderShipmentCost, Integer numOrderProduct, Integer orderProductQuantity, Integer orderProductPrice, String orderStatus) {
        
        Savepoint sp = Database.setSavepoint();
        
        Product2 pd = new Product2(Name = 'ProductTest', Family = 'family', IsActive = true);
        insert pd;

        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = pd.Id, UnitPrice = 50000, IsActive = true);
        insert pbe;
        
        Account acct = new Account(Name = 'TestAccount');
        insert acct;
        
            List<Order> ords = new List<Order>();
            for(Integer k = 0; k < numOrders; k++) {
                ords.add(new Order(AccountId = acct.Id, Pricebook2Id = Test.getStandardPricebookId(), Status = orderStatus, ShipmentCost__c = orderShipmentCost, EffectiveDate = System.today() + k));
            }
            insert ords;

            List<OrderItem> ordItems = new List<OrderItem>();
            for (Integer l = 0; l < numOrders; l++) {
                Order o = ords[l];
                for (Integer m = 0; m < numOrderProduct; m++) {
                    ordItems.add(new OrderItem(OrderId = o.Id, Product2Id = pd.Id, PriceBookEntryId = pbe.Id, Quantity = orderProductQuantity, UnitPrice = orderProductPrice));
                }
            }
        insert ordItems;
        return acct;
    }
    
    // Cette fonction retourne plusieurs comptes et reçoit en paramètres le nombre de comptes, de commandes, de produits de commande, la quantité de chaque produit de commande, le statut de chaque commande, le coût d'expédition de commande et les insère dans la base de données 
    public static List<Account> createMultipleAccountWithOrdsAndOrdProducts(Integer numAccounts, Integer numOrders, Integer orderShipmentCost, Integer numOrderProduct, Integer orderProductQuantity, Integer orderProductPrice, String orderStatus) {
        Savepoint sp = Database.setSavepoint();
        List<Account> accts = new List<Account>();
            for(Integer k = 0; k < numAccounts; k++) {
                Account acct = createOneAccountWithOrdsAndOrdProducts(numOrders, orderShipmentCost, numOrderProduct, orderProductQuantity, orderProductPrice, orderStatus);
                    accts.add(acct);
                }                                                                                
        upsert accts;
        return accts;
                                        
    }
    // This fuction set the Status of a list of Orders received in parameters to Ordered and then insert them into the database  
public static void setOrderStatusToOrdered(List<Order> ods,Integer orderNumber){
    List<Order> ords = new List<Order>();
    for(Integer n=0;n<orderNumber;n++){
        Order od = ods[n];
        od.Status = 'Ordered';
        ords.add(od);
    }
    update ords;
}
    }