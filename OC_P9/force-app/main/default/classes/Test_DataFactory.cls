@isTest
public class Test_DataFactory {
    //##############################################################
    // générer une liste de comptes
    public static List<Account> createAccounts(Integer nbAccount) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < nbAccount; i++) {
            Account account = new Account(Name='name_' + i);
            accounts.add(account);
        }
        insert accounts;
        return accounts;
    }

    //##############################################################
    // générer des commandes pour une liste de comptes donnée
    public static List<Order> createOrdersForAccounts(List<Account> accounts, Integer nbOrder, Integer unitPrice, Integer quantity) {
        // create Contracts and Orders
        List<Contract> contracts = new List<Contract>();
        List<Order> orders = new List<Order>();
        for (Account account : accounts) {
            Contract contract = new Contract(
                AccountId=account.id, 
                Status='Draft',
                ContractTerm=5
            );
            contracts.add(contract);

            for (Integer k = 0; k < nbOrder; k++) {
                Order order = new Order(
                    AccountId=account.id,
                    ContractId=contract.id,
                    Status='Draft',
                    EffectiveDate=Date.today(),
                    Pricebook2Id=Test.getStandardPricebookId()
                    );
                orders.add(order);
            }
        }
        insert contracts;
        insert orders;

        // create Product2, PricebookEntry, OrderItems and activate Orders
        Product2 product = new Product2(Name = 'Chemise Verte longue XYX', Family = 'Chemise');
        insert product;
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = Test.getStandardPricebookId(),
            Product2Id = product.Id,
            UnitPrice = unitPrice,
            IsActive = true
        );
        insert pbe;
        List<OrderItem> items = new List<OrderItem>();
        OrderItem item;
        for (Order order : orders) {
            item = new OrderItem (
                OrderId=order.Id,
                PricebookEntryId=pbe.Id,
                Quantity=quantity,
                UnitPrice=unitPrice
            );
            items.add(item);
        }
        insert items;

        return orders;
    }

    //##############################################################
    // générer un compte
    public static Account getAccount(String name, Boolean doInsert){
        Account a = new Account(name = name);
        if(doInsert){
            insert a;
        }
        return a;
    }
    //##############################################################
    // générer un contact
    public static Contact getContact(Id accountId, String fname, String lname, Boolean doInsert){
        Contact c = new Contact(firstName = fname, lastName = lname, accountId = accountId);
        if(doInsert){
            insert c;
        }
        return c;
    }

    //##############################################################
    // générer un compte avec des contacts associés
    public static void generateAccountWithContacts(Integer numContacts){
        Account a = getAccount('default account ltd', true);
        List<Contact> contacts = new List<Contact>();
        for(Integer i = 0; i < numContacts; i++){
            String contactName = 'contact' + i;
            contacts.add(getContact(a.id, contactName, contactName, false));
        }
        insert contacts;
    }

    //##############################################################
    // générer des opportunités pour un compte donné
    public static Opportunity[] generateOppsForAccount(id accountId, Decimal amount, Integer numOpps){
        List<Opportunity> opps = new List<Opportunity>();
        for(Integer i = 0; i < numOpps; i++){
            Opportunity o = new Opportunity();
            o.name = 'Account ' + i;
            o.accountId = accountId;
            o.amount = amount;
            o.closeDate = Date.today().addDays(5);
            o.stageName = 'Prospecting';
            opps.add(o);
        }
        return opps;
    }
    
    //##############################################################
    // générer un utilisateur de test
    public static User generateUser(String profileName){
        UserRole userRole = new UserRole(DeveloperName = 'TestingTeam', Name = 'Testing Team');
        insert userRole;
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = :profileName].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            Username = 'Cpt.Awesome@awesomesauce.com',
            CompanyName = 'Testing Co',
            Title = 'Captian',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            UserRoleId = userRole.Id
        );
        insert u;
        return u;
    }
}
