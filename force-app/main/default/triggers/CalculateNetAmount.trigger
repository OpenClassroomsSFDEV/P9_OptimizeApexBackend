// Déclencheur qui calcule le montant net pour les commandes mises à jour
trigger CalculateNetAmount on Order (before update) {
    // Parcourt toutes les commandes déclencheuses
    for(order ord : trigger.new){
        // Si le champ Montant_net__c ou le champ Coût_d_expédition__c est nul, les initialise à 0
        if(ord.Montant_net__c == null && ord.Coût_d_expédition__c== null){
            ord.Montant_net__c = 0;
        	ord.Coût_d_expédition__c =0;
        }    
        // Met à jour le champ Montant_net__c en utilisant la formule Montant_net = Montant_total - Coût_d_expédition
        ord.Montant_net__c = ord.Montant_total - ord.Coût_d_expédition;  
    }

}