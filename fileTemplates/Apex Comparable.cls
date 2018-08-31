global class ${NAME} implements Comparable
{
    public sObject sObjectRecord;
    
    public ${NAME}(sObject sObjectRecord){
        this.sObjectRecord = sObjectRecord;
    }
    
    global Integer compareTo(Object compareTo){
        ${NAME} comparison = (${NAME}) compareTo;
        
        Integer returnValue = 0;
        if (this.sObjectRecord.Id > comparison.sObjectRecord.Id){
            return 1;
        } else if (this.sObjectRecord.Id < comparison.sObjectRecord.Id){
            return -1;
        }
        return returnValue;
    }
}