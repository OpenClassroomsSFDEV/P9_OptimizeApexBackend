// OrderTrigger on Order object, before and after update
trigger OrderTrigger on Order (before update, after update) {
    
    // Checking if the trigger fires on an update
    if (Trigger.isUpdate) {
        
        // Retrieving the list of Order objects being modified
        List<Order> ordersList = Trigger.new;
        
        // Check if trigger is executed before update
        if (Trigger.isBefore) {
            // Calling the calculateNetAmountForOrder method of the OrderTriggerHandler to calculate the net amount of the Order
            OrderTriggerHandler.calculateNetAmountForOrder(ordersList);
        }
        // Check if trigger is executed after update
        else if (Trigger.isAfter) {
            // Calling the OrderTriggerHandler handler's updateAccountCA method to update the account revenue
            OrderTriggerHandler.updateAccountCA(ordersList);
        }
    }
}
