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
//methods inserts into DB new Person__c with FName and LName provided in parameters
public static void createPerson(String fName, String LName){
        Person__c insertNewPerson = new Person__c (First_Name__c=fName,Last_Name__c=LName);
        insert insertNewPerson;
        //Database.SaveResult sr = Database(insertNewPerson,false);
}

}