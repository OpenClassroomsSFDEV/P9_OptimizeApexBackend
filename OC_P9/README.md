# OpenClassrooms 
## Project P9 - Optimize Apex Backend
## Degraded Project


### Naming Conventions :
* **Class names:** UpperCamelCase :

	* Apex Class
		**`SObjectName_Function_Interface`** > `Account_CA_Batch`
	
	* Trigger Class
		**`SObjectName_Function`** > `Order_NetAmount`

	* Tests Class
		**`ClassName_Test`** > `Account_CA_Batch_Test`
		**`Trigger_ClassName_Test`** > `Trigger_Order_NetAmount_Test`


* **Methods:** camelCase: `doSomething`

* **Test Methods:** camelCase & underscore: `test_what_when`

* **SOQL**

	``` Apex
	List<SObject> myList = [SELECT fields
								FROM SObject
 								WHERE condition
							];
   ```