public class ToDoListService {

public static String getProjectStatus (List <Task__c> tasks, Date projectPlanedEndDate){

   String returnStatus='';


     Set <String> statuses = new Set <String> ();
		for (Task__c t: tasks){
		statuses.add(t.Status__c);
		}
    if (statuses.size()==1 && statuses.contains('Draft')) {returnStatus='Draft';} 
    if (statuses.contains('Started')){returnStatus='In Progress';}
    
    if (statuses.size()==1 && statuses.contains('Completed')) {
        returnStatus='Finished in Time';
        for (Task__c t: tasks){
            if (t.End_Date__c>projectPlanedEndDate) {returnStatus='Finished with Delay';}
        }
        }
    
    if (returnStatus.length()==0) {returnStatus='Draft';}

    return returnStatus;

}
}