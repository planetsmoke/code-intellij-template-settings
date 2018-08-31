@RestResource(urlMapping='/URI/*')
global with sharing class ${NAME} {

    public static Boolean dmlAllOrNothing = false;
    
    @HttpPost
    global static String handlePost() {
        List<sObject> sObjects = (List<sObject>) Util_Rest.deserialize(List<sObject>.class);
        if (sObjects == null) {
            return 'sObjects == null';
        }
        if (sObjects.isEmpty()){
            return 'sObjects.isEmpty()';
        }
        return JSON.serialize(${NAME}.upsertSObjects(sObjects));
    }
    
    public static List<RestResult> upsertSObjects(List<sObject> sObjects){
        List<RestResult> results = new List<RestResult>();
        List<Database.UpsertResult> upsertResults = Database.upsert(
            sObjects, sObject.ExtId_SObject__c, ${NAME}.dmlAllOrNothing
        );
        for (Integer i = 0; i < objects.size(); i++){
            if (upsertResults.get(i).isSuccess()){
                results.add(
                    new RestResult(
                        true, JSON.serialize(sObjects.get(i))
                    )
                );
            } else {
                results.add(
                    new RestResult(
                        false, 'something broke'
                    )
                );
            }
        }
        return results;
    }

    global class RestResult {
        public Boolean success;
        public String message;
        public String body;

        public RestResult(Boolean success, String body){
            this.success = success;
            this.message = success ? 'Success' : 'Failure';
            this.body = body;
        }
    }
}