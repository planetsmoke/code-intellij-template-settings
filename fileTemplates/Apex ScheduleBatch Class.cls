global class ${NAME} implements Schedulable, Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
    
    public Integer defaultBulkSize {get;set;}
    
    global void execute(SchedulableContext sc){
		Database.executeBatch(this, this.defaultBulkSize);
	}
	
    public static void schedule(Integer minutes){
        String mm = String.valueOf(minutes);
        ${NAME}.unschedule();
        ${NAME} batch = new ${NAME}();
        System.schedule('${NAME}', '0 ' + mm + ' * * * ?', batch);
    }
    
    public static void unschedule(){
        List<CronTrigger> cts = [
            SELECT Id
            FROM CronTrigger
            WHERE CronJobDetail.Name = '${NAME}'
        ];
        for (CronTrigger ct : cts){
            System.abortJob(ct.Id);
        }
    }
	
	global ${NAME}(){
	    this.defaultBulkSize = 1;
	}
	
	global Iterable<sObject> start(Database.BatchableContext bc){
	    // to do
	    return new List<sObject>();
	}
	
	global void execute(Database.BatchableContext BC, List<sObject> values) {
	    // to do
	}
	global void finish(Database.BatchableContext bc){
	    // to do
	}
}