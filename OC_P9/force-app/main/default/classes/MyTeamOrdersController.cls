// TODO : renommer la classe conformément au nom du fichier
public without sharing class VFC01_Team {
    // TODO : renommer la prop
    public decimal SumOders{
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order];
			return (decimal)groupedResults.get('total');

        }
        set;
    }
}