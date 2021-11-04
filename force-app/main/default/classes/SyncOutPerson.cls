public class SyncOutPerson {
    @AuraEnabled(cacheable=false)
    public static String pesSyncOut(Id personId){
        HttpRequest req = new HttpRequest();

        req.setMethod('POST');

        req.setHeader('recordId','application/json');
        req.setEndpoint('https://avenga-school.herokuapp.com/push-data');
        
        Person__c person = [SELECT Id,	Is_Synced__c,Full_name__c,Total_Amount_of_Projects__c,Total_Amount_of_Tasks__c
                            FROM Person__c 
                            WHERE Id = : personId];

        String serializedPerson = JSON.serialize(person);
        req.setBody(serializedPerson);
        
        Http http = new Http();

        HTTPResponse res = http.send(req);
        if(res.getStatusCode()==200){
            person.Is_Synced__c = true;
            update person;
            return ('Person Sync is configured');
          }  
        return ('Person Sync is not yet configured');

    }

}