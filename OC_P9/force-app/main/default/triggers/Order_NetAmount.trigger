/**
 * calcul du montant net avant mise à jour d'une commande
 */
trigger Order_NetAmount on Order (before update) {
	for(Order order : trigger.new){
		order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
	}
}