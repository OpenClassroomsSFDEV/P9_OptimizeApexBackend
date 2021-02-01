trigger OrderAccountCA on Order (after update) {
  // récupération de la liste des comptes pour les commandes actives
  set<Id> accountIds = new set<Id>();
  for(Order order : trigger.new){
    if(order.Status == 'Activated'){
      accountIds.add(order.AccountId);
    }
  }
  // mise à jour du CA
  if(accountIds.size() > 0){
    List<Account> accountsWithOrders = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
                                          FROM Account
                                          WHERE Id IN :accountIds
                                        ];
    AccountCAService.calculateCA(accountsWithOrders);
  }
}