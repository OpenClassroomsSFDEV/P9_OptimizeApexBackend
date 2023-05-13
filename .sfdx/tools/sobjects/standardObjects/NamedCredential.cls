// This file is generated as an Apex representation of the
//     corresponding sObject and its fields.
// This read-only file is used by the Apex Language Server to
//     provide code smartness, and is deleted each time you
//     refresh your sObject definitions.
// To edit your sObjects and their fields, edit the corresponding
//     .object-meta.xml and .field-meta.xml files.

global class NamedCredential {
    global Id Id;
    global Boolean IsDeleted;
    global String DeveloperName;
    global String Language;
    global String MasterLabel;
    global String NamespacePrefix;
    global Datetime CreatedDate;
    global User CreatedBy;
    global Id CreatedById;
    global Datetime LastModifiedDate;
    global User LastModifiedBy;
    global Id LastModifiedById;
    global Datetime SystemModstamp;
    /* L'URL de connexion au système externe.
    */
    global String Endpoint;
    /* Utilisé pour surveiller les utilisateurs qui accèdent au serveur externe. Anonyme signifie que l'identité d'un utilisateur n'est pas spécifiée pour l'accès à un serveur externe. Le Principal nommé utilise l'identité d'un utilisateur pour tous les utilisateurs qui accèdent au serveur externe.
    */
    global String PrincipalType;
    global Boolean CalloutOptionsGenerateAuthorizationHeader;
    global Boolean CalloutOptionsAllowMergeFieldsInHeader;
    global Boolean CalloutOptionsAllowMergeFieldsInBody;
    /* Ce service Salesforce ou tiers fournit le processus de connexion et approuve l'accès au système externe.
    */
    global AuthProvider AuthProvider;
    /* Ce service Salesforce ou tiers fournit le processus de connexion et approuve l'accès au système externe.
    */
    global Id AuthProviderId;
    global String JwtIssuer;
    global String JwtFormulaSubject;
    global String JwtTextSubject;
    global Integer JwtValidityPeriodSeconds;
    global String JwtAudience;
    global String AuthTokenEndpointUrl;
    global List<CustomHttpHeader> CustomHttpHeaders;
    global List<ExternalDataUserAuth> UserAuths;
    global List<SetupEntityAccess> SetupEntityAccessItems;
    global List<UserProvisioningConfig> NamedCredential;

    global NamedCredential () 
    {
    }
}