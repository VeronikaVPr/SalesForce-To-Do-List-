@isTest
private class ToDoListServiceTest {

    
    @isTest
    static void getProjectStatusTest (){
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Project__C project2 = new Project__C(Name = 'ProjectTest2',Planned_End_Date__c=date.newInstance(2022, 1, 1),Actual_End_Date__c=date.newInstance(2021, 1, 1), Status__c = 'Finished In Time');
        insert project2;   
        Project__C project3 = new Project__C(Name = 'ProjectTest3',Planned_End_Date__c=date.newInstance(2021, 1, 1));
        insert project3;   
        Project__C project4 = new Project__C(Name = 'ProjectTest4',Planned_End_Date__c=date.newInstance(2021, 1, 1));
        insert project4; 
        Project__C project5 = new Project__C(Name = 'ProjectTest5',Planned_End_Date__c=date.newInstance(2021, 1, 1));
        insert project5;  

        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;
        Person__c person2 = new Person__c (First_Name__c = 'FirstNameTest2', Last_Name__c = 'LastNameTest2');
        insert person2;

        Task__c recordTask1  = new Task__c(Name = 'TestData', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed', End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 31));
        insert recordTask2;
        Task__c recordTask3  = new Task__c(Name = 'TestData3', Person__c = person2.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask3;
        Task__c recordTask4  = new Task__c(Name = 'TestData4', Person__c = person2.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 14));
        insert recordTask4;
        Task__c recordTask5  = new Task__c(Name = 'TestData5', Person__c = person2.Id, Project__C = project3.Id, Status__c = 'Draft');
        insert recordTask5;
        Task__c recordTask6  = new Task__c(Name = 'TestData6', Person__c = person1.Id, Project__C = project3.Id, Status__c = 'Draft');
        insert recordTask6;
        Task__c recordTask7  = new Task__c(Name = 'TestData7', Person__c = person2.Id, Project__C = project4.Id, Status__c = 'Started');
        insert recordTask7;
        Task__c recordTask8  = new Task__c(Name = 'TestData8', Person__c = person1.Id, Project__C = project5.Id, Status__c = 'Completed');
        insert recordTask8;
        Task__c recordTask9  = new Task__c(Name = 'TestData9', Person__c = person2.Id, Project__C = project5.Id, Status__c = 'Draft');
        insert recordTask9;
        
        Test.startTest();
        List <Task__c> tasks1 =[SELECT Status__c,End_Date__c,Project__c FROM TASK__C where Project__c= : project1.Id];
        String result1 = ToDoListService.getProjectStatus(tasks1,project1.Planned_End_Date__c);      
        List <Task__c> tasks2 =[SELECT Status__c,End_Date__c,Project__c FROM TASK__C where Project__c= : project2.Id];
        String result2 = ToDoListService.getProjectStatus(tasks2,project2.Planned_End_Date__c);
        List <Task__c> tasks3 =[SELECT Status__c,End_Date__c,Project__c FROM TASK__C where Project__c= : project3.Id];
        String result3 = ToDoListService.getProjectStatus(tasks3,project3.Planned_End_Date__c);
        List <Task__c> tasks4 =[SELECT Status__c,End_Date__c,Project__c FROM TASK__C where Project__c= : project4.Id];
        String result4 = ToDoListService.getProjectStatus(tasks4,project4.Planned_End_Date__c);
        List <Task__c> tasks5 =[SELECT Status__c,End_Date__c,Project__c FROM TASK__C where Project__c= : project5.Id];
        String result5 = ToDoListService.getProjectStatus(tasks5,project4.Planned_End_Date__c);
        Test.stopTest();
        System.assertEquals('Finished with Delay', result1, 'getProjectStatusTest is not working. Must return Finished With Delay');
        System.assertEquals('Finished in Time', result2, 'getProjectStatusTest is not working. Must return Finished In Time');
        System.assertEquals('Draft', result3, 'getProjectStatusTest is not working. Must return Draft');
        System.assertEquals('In Progress', result4, 'getProjectStatusTest is not working. Must return In Progress');
        System.assertEquals('Draft', result5, 'getProjectStatusTest is not working. Must return Draft');
   
    }          
    @isTest
    static void createPersonTest(){
       ToDoListService.createPerson('Test','Testov');
       Test.startTest();
       List <Person__c> TestInsertPerson = [SELECT Full_Name__c, ID,Name FROM Person__c]; 
       Test.stopTest();
       system.assertEquals(1,TestInsertPerson.size(),'createPerson does not working');
    }

    @isTest
    static void startNewTaskTest(){
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;
        ToDoListService.startNewTask(project1.Id,person1.Id);
        Test.startTest();
        List <Task__c> startTask = [SELECT Id,Project__C,Person__C,Start_Date__c FROM Task__c];
        Test.stopTest();
        system.assertEquals(1,startTask.size(),'startNewTask does not working');
        system.assertEquals(Date.today(),startTask.get(0).Start_Date__c,'Start_Date__c not correct');
    }
    
    @isTest
    static void updateTaskStatusesForProject(){
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;
        Task__c recordTask1  = new Task__c(Name = 'TestData1', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Draft', End_Date__c = date.newInstance(2021, 10, 29));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed', End_Date__c = date.newInstance(2021, 10, 29));
        insert recordTask2;
        
        Test.startTest();
        ToDoListService.updateTaskStatusesForProject(project1.Id,'Started');
        Test.stopTest();
        for (Task__c task : [SELECT Id, Status__c, Project__C FROM Task__c WHERE Project__C = : project1.Id])
        System.assertEquals('Started',task.Status__c,'Not correct Status__c');
    }

    @isTest
    static void deleteProjectsTest(){
       
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Project__C project2 = new Project__C(Name = 'ProjectTest2',Planned_End_Date__c=date.newInstance(2022, 1, 1),Actual_End_Date__c=date.newInstance(2021, 1, 1), Status__c = 'Finished In Time');
        insert project2;


        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;
        Person__c person2 = new Person__c (First_Name__c = 'FirstNameTest2', Last_Name__c = 'LastNameTest2');
        insert person2;

        Task__c recordTask1  = new Task__c(Name = 'TestData', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed', End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 31));
        insert recordTask2;
        Task__c recordTask3  = new Task__c(Name = 'TestData3', Person__c = person2.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask3;
        Task__c recordTask4  = new Task__c(Name = 'TestData4', Person__c = person2.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 14));
        insert recordTask4;
        Task__c recordTask5  = new Task__c(Name = 'TestData5', Person__c = person2.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 14));
        insert recordTask5;

        Set <Id> forDeleteTest = new Set<Id>();
        forDeleteTest.add(project1.Id);
        
        Test.startTest();
        ToDoListService.deleteProjects(forDeleteTest);
        Test.stopTest();
        List <Task__c> tasks = [SELECT id, Project__C FROM Task__c];
        List <Project__c> projects = [SELECT id FROM Project__c];
        System.assertEquals(1,tasks.size(),'deleteProjectsTest does not working');
        System.assertEquals(1,projects.size(),'deleteProjectsTest does not working');
        List <Task__c> tasksDeleted = [SELECT id, Project__C FROM Task__c WHERE Project__C= :project1.Id];
        List <Project__c> projectsDeleted = [SELECT id FROM Project__c WHERE Id= :project1.Id];
        System.assertEquals(0,tasksDeleted.size(),'deleteProjectsTest does not working');
        System.assertEquals(0,projectsDeleted.size(),'deleteProjectsTest does not working');
    }
           
}