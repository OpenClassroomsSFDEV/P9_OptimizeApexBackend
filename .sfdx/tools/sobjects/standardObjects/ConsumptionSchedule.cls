// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ConsumptionSchedule {
    global Id Id;
    global SObject Owner;
    global Id OwnerId;
    global Boolean IsDeleted;
    global String Name;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global Boolean IsActive;
    global String Description;
    /* Le nombre d'unités de facturation auxquelles cette planification de consommation s'applique. Par exemple, si l'unité de durée de facturation est définie sur Mois, saisissez 12 pour appliquer les planifications de consommation pendant 12 mois. Appliquez des planifications de consommation jusqu'à 20 trimestres, 60 mois ou 5 ans.
    */
    global Integer BillingTerm;
    /* L'unité utilisée dans les conditions de facturation pour déterminer la fréquence de facturation.
    */
    global String BillingTermUnit;
    /* Plage : les prix de la planification utilisant uniquement la couche qui s'applique à la quantité d'utilisation. Bloc : l'utilisation dans une limite donnée reçoit une tarification égale à la valeur de sa couche.
    */
    global String Type;
    /* Les quantités et les taux d'utilisation appliquent cette unité de mesure.
    */
    global String UnitOfMeasure;
    /* Choisissez un cas d'utilisation spécifique pour évaluer l'utilisation dans cette planification. Correspond à une liste de sélection de contrôle pour le champ Type.
    */
    global String RatingMethod;
    /* L'utilisation est comparée à une planification de consommation si les enregistrements partagent la même valeur Attribut correspondant.
    */
    global String MatchingAttribute;
    global Integer NumberOfRates;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ConsumptionRate> ConsumptionRates;
    global List<ConsumptionScheduleFeed> Feeds;
    global List<ConsumptionScheduleHistory> Histories;
    global List<ConsumptionScheduleShare> Shares;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<EntitySubscription> FeedSubscriptionsForEntity;
    global List<ProcessInstance> ProcessInstances;
    global List<ProcessInstanceHistory> ProcessSteps;
    global List<ProductConsumptionSchedule> ProductConsumptionSchedules;
    global List<ContentVersion> FirstPublishLocation;
    global List<FeedComment> Parent;
    global List<FlowRecordRelation> RelatedRecord;

    global ConsumptionSchedule () 
    {
    }
}