// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class ExternalDataUserAuth {
    global Id Id;
    global Boolean IsDeleted;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    global SObject ExternalDataSource;
    global Id ExternalDataSourceId;
    global User User;
    global Id UserId;
    /* Spécifie comment Salesforce doit s'authentifier sur le serveur externe. L'authentification par mot de passe signifie qu'un nom d'utilisateur et un mot de passe sont requis pour l'authentification. Aucune authentification signifie que les identifiants ne sont pas requis.
    */
    global String Protocol;
    global String Username;
    global String Password;
    /* Ce service Salesforce ou tiers fournit le processus de connexion et approuve l'accès au système externe.
    */
    global AuthProvider AuthProvider;
    /* Ce service Salesforce ou tiers fournit le processus de connexion et approuve l'accès au système externe.
    */
    global Id AuthProviderId;

    global ExternalDataUserAuth () 
    {
    }
}