public with sharing class ${NAME}{
    public sObject record {get;private set;}
    public ${NAME}(ApexPages.StandardController sc){
        this.record = (sObject)sc.getRecord();
    }
}