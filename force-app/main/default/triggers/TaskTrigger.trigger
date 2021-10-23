trigger TaskTrigger  on Task__c (before insert, after insert, before update, after update,after delete) {

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
        TriggerHandler.onAfterInsert(Trigger.newMap);
        TriggerHandler.onAfterInserTUpdate(Trigger.newMap);
    } 
    if (Trigger.isUpdate){
      TriggerHandler.onAfterInserTUpdate(Trigger.newMap);
     } 
  }         
        

  if (Trigger.isBefore) {
    if (Trigger.isUpdate) {
      TriggerHandler.onBeforeUpdate(Trigger.oldMap, Trigger.new);
    }
  }
}