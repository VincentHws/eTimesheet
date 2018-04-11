
$(function () {
	// Numbox for claims amounts
    $('.TotalClaimAmount').NumBox({ 
    	symbol: '', 
    	places: 2 ,
    	sperator: ""
    });
    
    // Multiple Tabs
	$("#tabs").tabs();
	
	// Accordian
	$("#months").accordion({
		collapsible : true,
		heightStyle : "content"
	});
	
	// Enter Timesheet Delete Button
	$(".delete_row_btn").button({
		icon: "ui-icon-trash"
	});
	
	// Save Button
	$("#save_button").button({
		icon: "ui-icon-disk"
	});
	
	// Add Group Button
	$("#add_button").button({
		icon: "ui-icon-plus"
	});
	
	// Log Out Button
	$("#logOutButton").button({
		icon: "ui-icon-power"
	});
	
	// Enter Timesheet Add Button
	$("#AddGroupButton").button({
		icon: "ui-icon-plusthick"
	});
	
	// Create project button
	$(".create_project_button").button({
		icon: "ui-icon-document"
	});
	
	//Selectmenu for Project Name, Task Type, Location
	$(".SelectMenu").selectmenu({
		width: 200,
	});
	
	//Sortable for draggable table row
	$(".sortable").sortable({
		revert : true
	});
	
	// Logged In Info Dialog
	$(".dialog").dialog({
	    autoOpen: false,
	    show: {
	      effect: "bounce",
	      duration: 600
	    },
	    hide: {
	      effect: "puff",
	      duration:750
	    }
	});
});
