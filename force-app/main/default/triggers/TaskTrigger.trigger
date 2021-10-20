trigger TaskTrigger  on Task__c (before insert, after insert, before update, after update) {

        if (Trigger.isAfter) {
                if (Trigger.isInsert) {
                    TriggerHandler.onAfterInsert(Trigger.newMap);
                }  

        }

     if (Trigger.isUpdate) {
        TriggerHandler.onBeforeUpdate(Trigger.oldMap, Trigger.new);
        }


      if (Trigger.isAfter) {
        if (Trigger.isInsert|| Trigger.isUpdate)
                    TriggerHandler.onAfterInserTUpdate(Trigger.newMap);
                } 
     


}