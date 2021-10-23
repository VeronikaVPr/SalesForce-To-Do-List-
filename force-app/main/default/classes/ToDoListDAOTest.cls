@isTest
private class ToDoListDAOTest {
@testSetup
    static void dataSetup(){
   
        Project__C project1 = new Project__C(Name = 'ProjectTest1',Planned_End_Date__c=date.newInstance(2021, 1, 30),Actual_End_Date__c=date.newInstance(2021, 10, 10), Status__c = 'Finished With Delay');
        insert project1;
        Project__C project2 = new Project__C(Name = 'ProjectTest2',Planned_End_Date__c=date.newInstance(2021, 1, 1),Actual_End_Date__c=date.newInstance(2021, 1, 1), Status__c = 'Finished In Time');
        insert project2;   
        Project__C project3 = new Project__C(Name = 'ProjectTest3',Planned_End_Date__c=date.newInstance(2021, 1, 1),Actual_End_Date__c=date.newInstance(2021, 1, 1), Status__c = 'Finished In Time');
        insert project3;   

        Person__c person1 = new Person__c (First_Name__c = 'FirstNameTest',Last_Name__c = 'LastNameTest');
        insert person1;
        Person__c person2 = new Person__c (First_Name__c = 'FirstNameTest2', Last_Name__c = 'LastNameTest2');
        insert person2;

        Task__c recordTask1  = new Task__c(Name = 'TestData', Person__c = person1.Id, Project__C = project1.Id, Status__c = 'Completed', End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask1;
        Task__c recordTask2  = new Task__c(Name = 'TestData2', Person__c = person1.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 12, 31));
        insert recordTask2;
        Task__c recordTask3  = new Task__c(Name = 'TestData3', Person__c = person2.Id, Project__C = project1.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2021, 10, 21));
        insert recordTask3;
        Task__c recordTask4  = new Task__c(Name = 'TestData4', Person__c = person2.Id, Project__C = project2.Id, Status__c = 'Completed',End_Date__c = date.newInstance(2020, 10, 14));
        insert recordTask4;

    }
    @isTest
    static void getPersonTest(){
        List <Person__c> people = [SELECT Full_Name__c FROM Person__c];
        Id personId = people.get(0).Id;
        Test.startTest();
        Person__c result= ToDoListDAO.getPerson(personId);
        Test.stopTest();
        System.assertEquals(people.get(0),result,'ToDoListDAO.getPerson is working ');
    }

    @isTest
    static void getOverdueTasksByProjectIdsTest(){
        list <Person__c> Person =[SELECT Full_Name__c, Id,Name FROM Person__c];
        //Id person1Id = Person.get(0).Id;
        Set <Id> FullListPerson = new Set<Id>();          
        for (Person__c pers: Person){
           FullListPerson.add(pers.Id);
        }
        Map<Id, List<Task__c>> mapResult = new Map <Id, List<Task__c>> ();
        Test.startTest();
        mapResult = ToDoListDAO.getOverdueTasksByProjectIds(FullListPerson);
        Test.stopTest();
        System.assertEquals(2,mapResult.size(),'getOverdueTasksByProjectIdsTest does not return 2 for map.size()');
        for (Id pers: FullListPerson){
            list <Task__c> listFromResult= new list <Task__c>(mapResult.get(pers));
            for (Task__c taskForPers : listFromResult){
                System.assertEquals(pers,taskForPers.Person__c,'getOverdueTasksByProjectIdsTest returns map.Id!=list.id');
            }
            System.assertEquals(2,mapResult.get(pers).size(), 'Not correct tasks');
         }      
    }  

    @isTest
    static void getProjectsByPersonsIdsTest(){
        list <Person__c> Person =[SELECT Full_Name__c, ID,Name FROM Person__c];
        Set <Id> FullListPerson = new Set<Id>();
            
       for (Person__c p: Person){
           FullListPerson.add(p.id);
       }
       Map<Id, Set<Id>> MapResult = new Map <Id, Set<Id>>();
       Test.startTest();
       MapResult=ToDoListDAO.getProjectsByPersonsIds(FullListPerson);
       Test.stopTest();
       System.assertEquals(2,mapResult.size(),'getOverdueTasksByProjectIdsTest does not return 2 for map.size()');
        for (Id pers: FullListPerson){
            Set <Id> SetFromResultProject= new set <Id>(mapResult.get(pers));
            System.assertEquals(2,mapResult.get(pers).size(), 'Not correct project');
        }
    }    

    @isTest
    static void getFiveBiggestProjectsTest(){
        Test.startTest();
        List <AggregateResult> Result=ToDoListDAO.getFiveBiggestProjects();
        Test.stopTest();
        System.assertEquals(2,Result.size(), 'Not correct size');
    }

}