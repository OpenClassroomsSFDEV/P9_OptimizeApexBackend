public with sharing class MyTeamOrdersController {
    public Integer sumOders{
        get{
            // Obtenir la somme de toutes les commandes
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order where status ='Ordered'];
			return Integer.valueOf(groupedResults.get('total'));

        }
        set;
    }
}