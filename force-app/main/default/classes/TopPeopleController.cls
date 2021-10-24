public with sharing class TopPeopleController {
    @AuraEnabled
    
    public static List <Person__c> getTopPeople (Integer limitNumber){
        List <Person__c> retunResult = 
               [SELECT Name, Full_Name__c,Total_Amount_of_Projects__c,Total_Amount_of_Tasks__c
               FROM Person__c
               WHERE Total_Amount_of_Projects__c!=null ORDER BY Total_Amount_of_Projects__c desc LIMIT:limitNumber];
        return retunResult;
    }
}