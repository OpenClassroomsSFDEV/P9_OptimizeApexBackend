public with sharing class OrderTriggerHandler {

    /**
     * Method for calculating the net amount of orders.
     * @param ordersList The list of commands.
     * @return void
     */
    public static void calculateNetAmountForOrder(List<Order> ordersList) {
        for (Order ordr : ordersList) {
            if (ordr.ShipmentCost__c != null) {
                // Subtract the shipping cost from the total amount to get the net amount.
                ordr.NetAmount__c = ordr.TotalAmount - ordr.ShipmentCost__c;
            } else {
                // If the shipping cost is zero, the net amount is equal to the total amount.
                ordr.NetAmount__c = ordr.TotalAmount;
            }
        }
    }

    /**
     * Method for updating account revenue.
     * @param ordersList The list of commands.
     * @return void
     */
    public static void updateAccountCA(List<Order> ordersList) {

        Map<Id, Order> mapIdOrder = new Map<Id, Order>(ordersList);
        Set<Id> accRelatedId = new Set<Id>();
        for (Order ordr : mapIdOrder.values()) {
            if (ordr.get('Status') == 'Ordered') {
                // Add the associated account ID to orders with "Ordered" status.
                accRelatedId.add(ordr.AccountId);
            }
        }

        // Retrieve account records associated with unique IDs.
        List<Account> accList = [SELECT ID, Name, Chiffre_d_affaire__c FROM Account WHERE Id IN :accRelatedId];

        // Update revenue for accounts associated with orders.
        for (Order ordr : mapIdOrder.values()) {
            for (Account acc : accList) {
                if (acc.Id == ordr.get('AccountId')) {
                    if (acc.Chiffre_d_affaire__c != null) {
                        // Add the net amount to the existing account revenue.
                        acc.Chiffre_d_affaire__c += ordr.NetAmount__c;
                    } else {
                        // If the turnover is nil, update it with the net amount.
                        acc.Chiffre_d_affaire__c = ordr.NetAmount__c;
                    }
                }
            }
        }

        // Update modified account records.
        update accList;
    }
}