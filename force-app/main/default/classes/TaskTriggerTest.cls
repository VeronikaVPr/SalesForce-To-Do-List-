@isTest
private class TaskTriggerTest{
    @TestSetup
    static void dataSetup(){
   
        Project__C project = new Project__C(
            Name = 'ProjectTest'
        );
        insert project;
        Person__c person = new Person__c (
            First_Name__c = 'FirstNameTest',
            Last_Name__c = 'LastNameTest'
        );
        insert person;
        Person__c person2 = new Person__c (
            First_Name__c = 'FirstNameTest2',
            Last_Name__c = 'LastNameTest2'
        );
        insert person2;

        Task__c recordTask  = new Task__c(
            Name = 'TestData',
            Person__c = person.Id,
            Project__C = project.Id,
            Status__c = 'Completed'
        );
        insert recordTask;
    }
    @IsTest
    private static void onBeforeUpdateTest() {
        List <Task__c> tasks = [SELECT Id, Person__c, Status__c FROM TASK__C];
        Id prsonId1 = tasks.get(1).Person__c;
        
        Task__c task = tasks.get(0);
        task.Person__c = prsonId1;
        Test.startTest();
        Database.SaveResult result = Database.update(task);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals(
            'When the Task is Completed responsible Person cant be changed',
             result.getErrors()[0].getMessage()
        );
    }
}