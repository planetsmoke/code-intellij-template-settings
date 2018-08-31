public with sharing class ${NAME} {
    public List<Comparable_Object_Custom> comparables { get; private set; }
    public List<Object_Custom__c> object_Customs { get; private set; }

    public class WrapperException extends Exception {}
    public static String MISSING_CUSTOMER_ID = 'Missing Object_Custom__r.Order__r.Customer__c value';

    public ${NAME}(List<Object_Custom__c> object_Customs){
        this.object_Customs = object_Customs;
        this.comparables = new List<Comparable_Object_Custom>();
        for (Object_Custom__c orow : this.object_Customs){
            checkEntry(orow);
            this.comparables.add(new Comparable_Object_Custom(orow));
        }
    }

    public void addObject_Custom(Object_Custom__c orow){
        checkEntry(orow);
        this.object_Customs.add(orow);
        this.comparables.add(new Comparable_Object_Custom(orow));
    }
    public void addObject_Customs(List<Object_Custom__c> object_Customs){
        for (Object_Custom__c orow : object_Customs){
            addObject_Custom(orow);
        }
    }

    public List<Object_Custom__c> getObject_Customs(){
        this.comparables.sort();
        this.object_Customs = new List<Object_Custom__c>();
        for (Comparable_Object_Custom comparable : this.comparables){
            this.object_Customs.add(comparable.object_Custom);
        }
        return this.object_Customs;
    }

    private void checkEntry(Object_Custom__c object_Custom){
        try {
            if (String.isBlank(object_Custom.Order__r.Customer__c)){
                throw new WrapperException(${NAME}.MISSING_CUSTOMER_ID);
            }
        } catch (SObjectException e){
            throw new WrapperException(${NAME}.MISSING_CUSTOMER_ID);
        }
    }
}
/*
Test.startTest();

Aggr_Object_Custom aggrObject_Custom = new Aggr_Object_Custom([
    SELECT Id, Order__r.Customer__c
    FROM Object_Custom__c
    ORDER BY ExtID_Object_Custom__c
]);


List<Object_Custom__c> object_Customs = aggrObject_Custom.getObject_Customs();

Test.stopTest();

Id customerId;
for (Object_Custom__c object_Custom : object_Customs){
    if (String.isBlank(customerId)){
        customerId = object_Custom.Order__r.Customer__c;
        continue;
    }
    System.assert(object_Custom.Order__r.Customer__c > customerId);
    customerId = object_Custom.Order__r.Customer__c;
}
*/