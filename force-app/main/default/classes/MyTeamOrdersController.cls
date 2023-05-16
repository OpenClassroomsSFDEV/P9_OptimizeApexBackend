// Définit une classe MyTeamOrdersController
// Cette classe permet d'obtenir la somme de toutes les commandes dans le statut "Ordered"
public with sharing class MyTeamOrdersController {
    
    // Déclare une propriété sumOders de type Integer avec un accesseur get et un accesseur set
    // Cette propriété retourne la somme de toutes les commandes dans le statut "Ordered"
    public decimal sumOders{
        
    // Définit l'accesseur get qui récupère la somme de toutes les commandes
        get{
    // Obtenir la somme de toutes les commandes dans le statut "Ordered"
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order where status ='Ordered'];
            
    // Convertit le résultat de la requête en une valeur entière et le retourne
        return (decimal)groupedResults.get('total');
    }
        
    // Définit l'accesseur set
        set;
    }
}