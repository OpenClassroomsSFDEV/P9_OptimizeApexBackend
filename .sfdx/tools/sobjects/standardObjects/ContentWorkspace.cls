// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ContentWorkspace {
    global Id Id;
    global String Name;
    global String Description;
    global String TagModel;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime CreatedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global Datetime LastModifiedDate;
    global RecordType DefaultRecordType;
    global Id DefaultRecordTypeId;
    global Boolean IsRestrictContentTypes;
    global Boolean IsRestrictLinkedContentTypes;
    global String WorkspaceType;
    global Boolean ShouldAddCreatorMembership;
    global Datetime LastWorkspaceActivityDate;
    global ContentFolder RootContentFolder;
    global Id RootContentFolderId;
    global String NamespacePrefix;
    global String DeveloperName;
    /* Habillez votre bibliothèque avec une image. Une image en 16:9 (par exemple 480 par 270 pixels) produit les meilleurs résultats. Tous les utilisateurs peuvent afficher cette image, même s’ils ne sont pas membres de la bibliothèque.
    */
    global ContentAsset WorkspaceImage;
    /* Habillez votre bibliothèque avec une image. Une image en 16:9 (par exemple 480 par 270 pixels) produit les meilleurs résultats. Tous les utilisateurs peuvent afficher cette image, même s’ils ne sont pas membres de la bibliothèque.
    */
    global Id WorkspaceImageId;
    global List<AttachedContentDocument> AttachedContentDocuments;
    global List<CombinedAttachment> CombinedAttachments;
    global List<ContentDocumentLink> ContentDocumentLinks;
    global List<ContentFolderLink> ContentFolderLinks;
    global List<ContentWorkspaceMember> ContentWorkspaceMembers;
    global List<ContentDocument> Parent;
    global List<ContentNotification> EntityIdentifier;
    global List<ContentVersion> FirstPublishLocation;
    global List<ContentWorkspaceDoc> ContentWorkspace;

    global ContentWorkspace () 
    {
    }
}