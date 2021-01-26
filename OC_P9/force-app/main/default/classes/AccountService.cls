global without sharing class AccountService {
    /**
     * calcul et mise à jour du chiffre d'affaire de comptes
     */
    global static void calculateCA(List<Account> accountsWithOrders) {
        for(Account myAccount : accountsWithOrders){
            myAccount.Chiffre_d_affaire__c = 0;
            for(Order order : myAccount.Orders){
                myAccount.Chiffre_d_affaire__c += order.TotalAmount;
            }
        }
        update accountsWithOrders;
    }
}
