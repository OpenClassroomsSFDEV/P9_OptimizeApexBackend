// Define a MyTeamOrdersController class
// This class is used to obtain the sum of all orders in the "Ordered" status
public with sharing class MyTeamOrdersController {
    
    // Declare a sumOders property of type Integer with a get accessor and a set accessor
    // This property returns the sum of all orders in the "Ordered" status
    public decimal sumOders{
        
    // Define the get accessor that retrieves the sum of all commands
        get{
    // Get the sum of all orders in "Ordered" status
        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order where status ='Ordered'];
            
    // Convert the query result to an integer value and return it
        return (decimal)groupedResults.get('total');
    }
        
    // Set the set accessor
        set;
    }
}