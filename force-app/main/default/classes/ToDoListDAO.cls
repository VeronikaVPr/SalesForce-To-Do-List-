public class ToDoListDAO {

//get Person__c by Id
    public static Person__c getPerson(Id personId){
        Person__c findPerson =[SELECT Full_Name__c FROM Person__c where ID=:personId];
        return findPerson;
    }

//Get overdue tasks for specific people. Result tasks should be grouped by project ids
     public static Map<Id,List<Task__c>> getOverdueTasksByProjectIds(Set <Id> FullListPerson){
       
        Map<Id, List<Task__c>> MapResult = new Map <Id, List<Task__c>> ();
        List <Task__c> tastkList = [SELEcT Id,Project__c,Name__c,Status__c,Person__c FROM Task__c WHERE Person__c in :FullListPerson and Project__r.Status__c = 'Finished With Delay'];
                
        for(Id p:FullListPerson){
            List <Task__c> resultList = new List <Task__c>();
            for (Task__c t:tastkList) {
                if(t.Person__c==p)
                resultList.add(t);
            }                                                              
            MapResult.put(p, resultList);

        }
         return MapResult;
     }
    
//return Map of next format:Id - Person__c.Id, Set<Id> - set of Project__c.Id where Person participated
     public static Map<Id,Set<Id>> getProjectsByPersonsIds(Set <Id> FullSetPeople){

        Map<Id, Set<Id>> MapResult = new Map <Id, Set<Id>>();

        List <Task__c> tasks = new List <Task__c> ([SELECT Project__c,Person__c FROM Task__c WHERE Person__c IN : FullSetPeople]);

        for (Id personId:FullSetPeople) {
            Set <Id> ResultProject = new Set <Id>();                
            for (Task__c task:tasks){
                if(task.Person__c==personId) 
                    ResultProject.add(task.Project__c);
            }
     
            if (!ResultProject.isEmpty ()){
                MapResult.put(personId, ResultProject);
            }
        }
        return MapResult;
	} 
    
//get 5 Projects of ANY Status with the biggest number of participated People
    public static List<AggregateResult> getFiveBiggestProjects(){
        List <AggregateResult> Result = new List <AggregateResult>([SELECT Project__c, count(Id) People FROM Task__c group by Project__c order by  count(Id) desc LIMIT 5]);
        return Result;        
    }

}