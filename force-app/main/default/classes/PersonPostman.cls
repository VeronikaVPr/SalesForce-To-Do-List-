@RestResource(urlMapping='/*')
global class PersonPostman {
    
    @HttpGet
    global static List<Person__c> getHighestTaskPeople(){
        return new List<Person__c>([SELECT Id, Full_name__c,Total_Amount_of_Projects__c 
                                    FROM Person__c 
                                    order by Total_Amount_of_Projects__c desc LIMIT 5 ]);
    }

}