# OpenClassrooms

## Project P9 - Optimize Apex Backend

## Degraded Project

### Naming Conventions :

- **Class names:** UpperCamelCase :

  - Apex Class
    **`SObjectNameFunctionInterface`** > `AccountCABatch`

  - Trigger Class
    **`SObjectNameFunction`** > `OrderNetAmount`

  - Tests Class
    **`ClassNameTest`** > `AccountCABatchTest`
    **`TriggerClassNameTest`** > `TriggerOrderNetAmountTest`

- **Methods:** camelCase: `doSomething`

- **Test Methods:** camelCase: `testWhatWhen`

- **SOQL**

  ```Apex
  List<SObject> myList = [SELECT fields
  							FROM SObject
  							WHERE condition
  						];
  ```
