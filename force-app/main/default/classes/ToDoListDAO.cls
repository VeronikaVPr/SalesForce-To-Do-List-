public class ToDoListDAO {

    //get Person__c by Id
    public static void getPerson(Id personId){
        List <Person__c> findPerson =[SELECT Full_Name__c FROM Person__c where ID=:personId];
        System.debug(findPerson);
    }
    //Get overdue tasks for specific people. Result tasks should be grouped by project ids
    public static Map<Id,List<AggregateResult>> getOverdueTasksByProjectIds(Set <Id> FullListPerson){
            Map<Id, List<AggregateResult>> MapResult = new Map <Id, List<AggregateResult>> ();
              for (Id p:FullListPerson) {
                  List <AggregateResult> ResultTask = new List <AggregateResult>([SELECT Project__c, count(Id) people FROM Task__c WHERE Project__r.Status__c != 'Finished With Delay' and Person__c IN : new Set<ID>{p} group by Project__c]);
                  
                  if (!ResultTask.isEmpty ()){
                  MapResult.put(p, ResultTask);
                  }
              }
            return MapResult;
     }
    
    //return Map of next format:Id - Person__c.Id, Set<Id> - set of Project__c.Id where Person participated
    public static Map<Id,Set<Id>> getProjectsByPersonsIds(Set <Id> FullSetPeople){

    Map<Id, Set<Id>> MapResult = new Map <Id, Set<Id>> ();

               for (Id p:FullSetPeople) {
                    List <Task__c> ListProject = new List <Task__c>([SELECT Project__c FROM Task__c WHERE Person__c IN : new Set<ID>{p}]);
                    Set <Id> ResultProject = new Set <Id>();
                    for (Task__c lp:listProject){
                       ResultProject.add(lp.Project__c);
                    }
     
                  if (!ResultProject.isEmpty ()){
                  MapResult.put(p, ResultProject);
                }
               }
        return MapResult;
		} 
    
    //get 5 Projects of ANY Status with the biggest number of participated People
    public static List<AggregateResult> getFiveBiggestProjects(){
        List <AggregateResult> Result = new List <AggregateResult>([SELECT Project__c, count(Id)  FROM Task__c group by Project__c order by  count(Id) desc LIMIT 5]);
        return Result;
        
    }
}