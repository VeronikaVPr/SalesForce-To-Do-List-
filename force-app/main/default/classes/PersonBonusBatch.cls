public class PersonBonusBatch implements Database.Batchable<sObject>,  Schedulable{

    public void execute(SchedulableContext ctx) {
        PersonBonusBatch MonthlyPersonBonusBatch = new PersonBonusBatch();
        Id batchId = Database.executeBatch(MonthlyPersonBonusBatch);
   }
   
   

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
        [SELECT Id, Bonus__c FROM Person__c]
        );
    }

    public void execute(Database.BatchableContext bc, List<Person__c> people) {
        Set <Id> peopleSet = new Set<Id>();
        for (Person__c person : people){
            peopleSet.add(person.Id);
        }
        List <Task__c> tasks = 
            [SELECT Id, Person__c, End_Date__c 
            FROM Task__c 
            WHERE Status__c = : 'Completed' and Person__c IN :peopleSet];
        for (Person__c person : people){
            Integer countTasks = 0;
            for (Task__c task : tasks){
                Date todayDate = Date.today();
                Integer monthsBetween = task.End_Date__c.monthsBetween(todayDate);
                if (person.Id == task.Person__c&&monthsBetween==1){
                    countTasks++;
                }
            }
        person.Bonus__c=25*countTasks;
        }    
        update people;
             
     }

    public void finish(Database.BatchableContext bc) {
        
    }


}