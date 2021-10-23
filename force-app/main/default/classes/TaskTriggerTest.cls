@isTest
private class TaskTriggerTest{

    @isTest
    static void onAfterInsert (){
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Project__C project2 = new Project__C(Name = 'ProjectTest2',Planned_End_Date__c=date.newInstance(2022, 1, 1),Actual_End_Date__c=date.newInstance(2021, 1, 1), Status__c = 'Finished In Time');
        insert project2; 

        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest',Total_Amount_of_Projects__c=0,Total_Amount_of_Tasks__c=0);
        insert person1;

        Task__c recordTask1  = new Task__c(Name = 'TestData', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed', End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 7, 31));
        insert recordTask2;
        

        Test.startTest();
        Task__c recordInsertTeat  = new Task__c(Name = 'TestData3', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2021, 10, 21));
        insert recordInsertTeat;
       // Database.SaveResult result = Database.insert(recordInsertTeat,false);
        Test.stopTest();

        Person__c personResult = [SELECT Id,Total_Amount_of_Projects__c,Total_Amount_of_Tasks__c FROM Person__c WHERE Id  = : person1.Id ];
       
        System.assertEquals(2,personResult.Total_Amount_of_Projects__c, 'onAfterInsert: Total_Amount_of_Projects__c not correct ');
        System.assertEquals(3,personResult.Total_Amount_of_Tasks__c, 'onAfterInsert: Total_Amount_of_Tasks__c not correct ');
    }

    @IsTest
    static void onBeforeUpdateTest() {
        Project__C project = new Project__C(Name = 'ProjectTest');
        insert project;
        Person__c person = new Person__c (First_Name__c = 'FirstNameTest', Last_Name__c = 'LastNameTest');
        insert person;
        Person__c person2 = new Person__c (First_Name__c = 'FirstNameTest2', Last_Name__c = 'LastNameTest2' );
        insert person2;

        Task__c recordTask  = new Task__c( Name = 'TestData', Person__c = person.Id, Project__C = project.Id, Status__c = 'Completed'        );
        insert recordTask;
   
        recordTask.Person__c = person2.Id;
        Test.startTest();
        Database.SaveResult result = Database.update(recordTask,false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals(
            'When the Task is Completed responsible Person cant be changed',
             result.getErrors()[0].getMessage()
        );
    }

    @isTest
    static void onAfterInserTUpdateTest(){
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10));
        insert project1;

        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;

        Task__c recordTask1  = new Task__c(Name = 'TestData', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Draft', End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Draft',End_Date__c = date.newInstance(2020, 7, 31));
        insert recordTask2;     
        
        Task__c recordTask3  = new Task__c(Name = 'TestData3', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Started',End_Date__c = date.newInstance(2021, 10, 24));
        
        Test.startTest(); 
        insert recordTask3;
        Test.stopTest();
        
        Project__C resultProject = [SELECT Id, Status__c FROM Project__C WHERE Id =:project1.Id];
        System.assertEquals('In Progress', resultProject.Status__c, 'It is not working. Must return ');

    }
}