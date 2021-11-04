import { LightningElement ,api, wire, track} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import getUpcomingTaskCurrentPerson from '@salesforce/apex/PersonRecordPageController.getUpcomingTaskCurrentPerson';
import pesSyncOut from '@salesforce/apex/SyncOutPerson.pesSyncOut';

import Id from '@salesforce/schema/Person__c.Id';
const FIELDS = ['Task__c.Name', 'Task__c.Start_Date__c'];

export default class PersonRecordPage extends LightningElement {
  
  @track columns = [{
    label: 'Task name',
    fieldName: 'Name',
    type: 'text',
   },
  {
    label: 'Start Date',
    fieldName: 'Start_Date__c',
    type: 'date',
  }
];
  
  @api recordId;
 
  @wire(getUpcomingTaskCurrentPerson,{ personId: '$recordId' })  tasks;

  @track clickedButtonLabel;
  
  handleClick(event) {

      pesSyncOut({
        personId: this.recordId
      })
      .then(response => {
        alert(response);
      })
      .catch(error => console.error(error.body.message))

  }
    
  }