public without sharing class OrdersTeamController {
    /**
     * calcul du montant total des commandes
     */
    public decimal ordersSum{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');
        }
        private set;
    }
    
}