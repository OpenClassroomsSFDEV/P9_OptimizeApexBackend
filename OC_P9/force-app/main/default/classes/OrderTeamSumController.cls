public without sharing class OrderTeamSumController {
    /**
     * calcul du montant total des commandes
     */
    public decimal ordersSum{
        get{
            AggregateResult groupedResults = [SELECT SUM(TotalAmount) total
                                                FROM Order
                                                WHERE Status = 'Activated'
                                            ];
			return (decimal)groupedResults.get('total');
        }
        private set;
    }
    
}