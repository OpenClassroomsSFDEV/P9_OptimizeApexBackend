// Cette classe est utilisée pour créer des données de test pour les tests de déclencheurs et de contrôleurs.
@isTest
public with sharing class TestDataFactory {
    
    // Cette fonction retourne un compte et reçoit en paramètres le nombre de commandes, de produits de commande, la quantité de chaque produit de commande, le statut de chaque commande, le coût d'expédition de commande et les insère dans la base de données
    public static Account createOneAccountWithOrdsAndOrdProducts(Integer numOrders, Integer orderShipmentCost, Integer numOrderProduct, Integer orderProductQuantity, Integer orderProductPrice, String orderStatus) {
        
    // Définir un point de sauvegarde pour pouvoir annuler toutes les opérations de base de données si nécessaire.
        Savepoint sp = Database.setSavepoint();
        
    // Créer un produit de test.
        Product2 pd = new Product2(Name = 'ProductTest', Family = 'family', IsActive = true);
        insert pd;

    // Créer une entrée de catalogue de prix pour le produit créé.
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = pd.Id, UnitPrice = 50000, IsActive = true);
        insert pbe;
        
    // Créer un compte pour les commandes.
        Account acct = new Account(Name = 'TestAccount');
        insert acct;
        
    // Créer une liste de commandes et les insérer dans la base de données.
        List<Order> ords = new List<Order>();
        for(Integer k = 0; k < numOrders; k++) {
            ords.add(new Order(AccountId = acct.Id, Pricebook2Id = Test.getStandardPricebookId(), Status = orderStatus, ShipmentCost__c = orderShipmentCost, EffectiveDate = System.today() + k));
        }
        insert ords;

    // Créer une liste de produits de commande et les insérer dans la base de données.
        List<OrderItem> ordItems = new List<OrderItem>();
        for (Integer l = 0; l < numOrders; l++) {
            Order o = ords[l];
            for (Integer m = 0; m < numOrderProduct; m++) {
                ordItems.add(new OrderItem(OrderId = o.Id, Product2Id = pd.Id, PriceBookEntryId = pbe.Id, Quantity = orderProductQuantity, UnitPrice = orderProductPrice));
            }
        }
        insert ordItems;
        
    // Retourner le compte créé.
        return acct;
    }
    
    // Cette fonction retourne plusieurs comptes et reçoit en paramètres le nombre de comptes, de commandes, de produits de commande, la quantité de chaque produit de commande, le statut de chaque commande, le coût d'expédition de commande et les insère dans la base de données 
    public static List<Account> createMultipleAccountWithOrdsAndOrdProducts(Integer numAccounts, Integer numOrders, Integer orderShipmentCost, Integer numOrderProduct, Integer orderProductQuantity, Integer orderProductPrice, String orderStatus) {
    // Définir un point de sauvegarde pour pouvoir annuler toutes les opérations de base de données si nécessaire.
        Savepoint sp = Database.setSavepoint();
        
    // Créer une liste de comptes en appelant la fonction createOneAccountWithOrdsAndOrdProducts.
        List<Account> accts = new List<Account>();
            for(Integer k = 0; k < numAccounts; k++) {
                Account acct = createOneAccountWithOrdsAndOrdProducts(numOrders, orderShipmentCost, numOrderProduct, orderProductQuantity, orderProductPrice, orderStatus);
                    accts.add(acct);
                }                                                                                
        upsert accts;
        return accts;
                                        
    }
    // modifier le statut d'une liste de commandes et de les insérer dans la base de données 
    public static void setOrderStatusToOrdered(List<Order> ods,Integer orderNumber){
    // créer une nouvelle liste de commandes appelée "ords"
        List<Order> ords = new List<Order>();
    // boucle sur le nombre de commandes spécifié en paramètre et pour chaque commande
        for(Integer n=0;n<orderNumber;n++){
        Order od = ods[n];
    // modifie son statut en "Ordered"
        od.Status = 'Ordered';
    // ajoute à la liste "ords"
        ords.add(od);
    }
    //mettre à jour la liste "ords" dans la base de données avec les nouvelles valeurs du statut des commandes
    update ords;
}
    }