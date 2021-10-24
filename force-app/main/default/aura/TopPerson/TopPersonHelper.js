({
	getPeople: function(component, event, helper) {
		var action = component.get("c.getTopPeople");

		action.setParams({
			"limitNumber" : component.get("v.limitNumber")
		});       
        action.setCallback(this,function(response) {
            component.set("v.people",response.getReturnValue());
        });

			$A.enqueueAction(action);
	},

	setColumns : function(component){
		component.set ('v.columns', [
			{label: 'Name',fieldName: 'Name', type: 'text'},
			{label: 'FullName',fieldName: 'Full_Name__c',type: 'Formula (Text)'},
			{label: 'Total Projects',fieldName: 'Total_Amount_of_Projects__c',type: 'Number(18, 0)'},
			{label: 'Total Tasks',fieldName: 'Total_Amount_of_Tasks__c',type: 'Number(18, 0)'}
		]);
	}
})