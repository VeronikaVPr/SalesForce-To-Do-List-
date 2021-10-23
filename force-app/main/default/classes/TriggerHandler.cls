public with sharing class TriggerHandler {
 //Total Amount Tasks and Total Amount Projects on Person should display the correct information.
    public static void onAfterInsert(Map<Id,Task__c> newMapTasks) {
            
            Set<Id> taskId = newMapTasks.keySet();
 
            list <Task__c> task =[SELECT Id, Person__c,Project__C FROM Task__c WHERE Id IN : taskId];
            Set <Id> peopleId = new Set <Id> ();
            for (Task__c t: task){
                peopleId.add(t.Person__c);
            }

             list <Person__c> people =[SELECT Id, Total_Amount_of_Projects__c, Total_Amount_of_Tasks__c FROM Person__c WHERE Id IN : peopleId];
             list <Task__c> taskAll = [SELECT  Id, Person__c,Project__C FROM Task__c WHERE Person__c IN : peopleId ];

            Integer newTotalTasks;
           
                for (Person__c p: people){
                    newTotalTasks =0;
                    Set <Id> project = new Set <Id> ();
                    for(Task__c t: taskAll){
                            If(p.Id == t.Person__c){
                                newTotalTasks++;
                                project.add(t.Project__C);
                        }
                    }
                 
                    p.Total_Amount_of_Tasks__c = newTotalTasks;
                    p.Total_Amount_of_Projects__c = project.size();
                }
                update people;
            }
    
       
    

//When the Task is Completed responsible Person can't be changed.
    public static void onBeforeUpdate(Map<Id, Task__c> oldTasksMap, List<Task__c> newTasks) {
        
        for (Task__c newTask : newTasks) {
            Task__c oldTask = oldTasksMap.get(newTask.Id);
            if (oldTask.Status__c == 'Completed' && oldTask.Person__c !=newTask.Person__c ) {
                newTask.addError('When the Task is Completed responsible Person cant be changed');
            }
        }
    }
    

  //  Project status should be based on the related Tasks. Use getParentStatus() method from ToDoListService.
  public static void onAfterInserTUpdate(Map<Id,Task__c> newMapTasks) {
    
    Set<Id> taskId = newMapTasks.keySet();
 
    list <Task__c> task =[SELECT Id, Project__C, End_Date__c, Status__c FROM Task__c WHERE Id IN : taskId];
    
    Set <Id> setProject = new Set <Id> ();
    for (Task__c t: task){
        setProject.add(t.Project__C);
    }
    
    
    list <Project__c> projects = [SELECT Id, Status__c,Planned_End_Date__c FROM Project__C WHERE Id IN: setProject];
    
    for (Project__C p: projects){
        List <Task__c> taskOneProect = new List <Task__c>();
        For (Task__c t: task){
          if(p.Id == t.Project__C) taskOneProect.add(t);
        }
       
        p.Status__c=ToDoListService.getProjectStatus(taskOneProect,p.Planned_End_Date__c);

     
    }
    update projects;
}

}