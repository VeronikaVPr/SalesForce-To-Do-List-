import { LightningElement , track} from 'lwc';
import getUpcomingTaskCurrentPerson from '@salesforce/apex/PersonRecordPageController.getUpcomingTaskCurrentPerson';

export default class PersonRecordPage extends LightningElement {
  clickedButtonLabel;

  handleClick(event) {
      this.clickedButtonLabel ='Person Sync is not yet configured';
  }
  
}