({
	doInit:function(component, event, helper) {
		helper.setColumns(component);
		helper.getPeople (component,event,helper);	
	},

	reLoadPeople : function(component, event, helper){
		helper.getPeople(component, event, helper);
	}
})