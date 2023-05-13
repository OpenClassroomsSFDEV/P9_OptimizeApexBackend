// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class Recommendation {
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
    global Datetime LastViewedDate;
    global Datetime LastReferencedDate;
    global String ActionReference;
    global String Description;
    /* Pour obtenir de meilleurs résultats, utilisez une image de 1000 x 380 pixels d'une résolution de 72 dpi ou avec un ratio similaire.
    */
    global ContentAsset Image;
    /* Pour obtenir de meilleurs résultats, utilisez une image de 1000 x 380 pixels d'une résolution de 72 dpi ou avec un ratio similaire.
    */
    global Id ImageId;
    global String AcceptanceLabel;
    global String RejectionLabel;
    global Boolean IsActionActive;
    global String ExternalId;
    global List<FlowRecordRelation> RelatedRecord;

    global Recommendation () 
    {
    }
}