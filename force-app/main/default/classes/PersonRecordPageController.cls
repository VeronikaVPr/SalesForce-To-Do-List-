public with sharing class  PersonRecordPageController {
    @AuraEnabled(cacheable=true)
    
    public static List <Task__c> getUpcomingTaskCurrentPerson(Id personId){
        return [SELECT Name, Start_date__c
                FROM Task__c 
                WHERE Start_date__c != NULL and Start_date__c > : Date.today() and Person__c = : personId order by Start_date__c];
    }
}