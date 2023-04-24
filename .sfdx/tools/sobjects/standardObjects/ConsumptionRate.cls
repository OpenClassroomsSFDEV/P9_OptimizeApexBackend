// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ConsumptionRate {
    global Id Id;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    /* Ce taux fait partie de cette planification.
    */
    global ConsumptionSchedule ConsumptionSchedule;
    /* Ce taux fait partie de cette planification.
    */
    global Id ConsumptionScheduleId;
    global String Description;
    /* L'ordre de traitement du taux d'utilisation entre des taux multiples. Les évaluations de la consommation sont évaluées en commençant par l'ordre de traitement le plus faible.
    */
    global Integer ProcessingOrder;
    /* Choisissez si l'utilisation est tarifée par unité ou quantité, ou en tant que montant forfaitaire
    */
    global String PricingMethod;
    /* La quantité d'utilisation la plus faible de cette évaluation de la consommation.
    */
    global Integer LowerBound;
    /* La quantité d'utilisation la plus élevée de cette évaluation de la consommation.
    */
    global Integer UpperBound;
    /* Le prix de l'utilisation comprise dans les limites de cette évaluation de la consommation.
    */
    global Decimal Price;
    global List<ConsumptionRateHistory> Histories;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<FlowRecordRelation> RelatedRecord;

    global ConsumptionRate () 
    {
    }
}