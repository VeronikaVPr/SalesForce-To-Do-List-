public with sharing class ToDoListService {

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
  }
  
  /*create new Task with Project and Person shown in parameters, 
  Start_Day__c must be set today's date, Status - draft */
  
  public static void startNewTask (Id projectId, Id personId){
            Date myDT = Date.today();
            Task__c insertTask = new Task__c (Project__c=projectId,Person__c=personId,Start_Date__c=myDT,Status__c='Draft');
            insert insertTask;          
  }
  
  //Update statuses for all tasks of specified project
  public static void updateTaskStatusesForProject(Id projectId, String newStatus){
      List <Task__c> tasks =[SELECT Status__c,Id FROM TASK__C where Project__c= : projectId];
      
      for (Task__c t: tasks){
          t.status__c=newStatus;
      }
      update tasks;
  }
  //method deletes Projects with Ids passed in parameters and tasks related to these Projects
  public static void deleteProjects (Set<Id> projectId){
          Delete [SELECT Id FROM TASK__C where Project__c In : projectId];
          Delete [SELECT Id FROM Project__C where Id In : projectId];
      }
  
  }