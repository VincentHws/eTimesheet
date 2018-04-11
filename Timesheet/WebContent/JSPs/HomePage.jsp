<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>TRISILCO Timesheet</title>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script src="JSPs/Resources/jQuery.timepicker/jquery.timepicker.min.js"></script>
<script src="JSPs/Resources/jQuery.simpletablesort/jquery.simpleTableSort.js"></script>
<script src="JSPs/Resources/jQuery.number/jquery.numbox-1.3.0.min.js"></script>

<script src="JSPs/Resources/HomePage/HomePage.js"></script>

<link rel="icon" href="JSPs/Resources/Common/Trisilco-Logo.png">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/jQuery.number/jquery.numbox-1.3.0.css">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/jQuery.timepicker/jquery.timepicker.css">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/jQuery.ui/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/HomePage/HomePage.css">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- CSS Styling -->
<style type="text/css">
.ui-menu {
	width: 200px;
}

ul li {
	font-size: 16px;
}

ul.MenuFont li {
	font-size: 15px;
	font-family: Arial;
}

/* Fix height for tabs */
.ui-tabs-panel {
	height: 500px;
    overflow: auto;
}

table.MaintainGroup td {
  font-size: 13px;
}
</style>

<!-- jQuery -->
<script>
function isNumberKey(evt)
{
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57))
      return false;

   return true;
}

// Constructing XML for BIRT report generation
$(function(){
	$(".Monthly_ViewTask").button({
		icon: "ui-icon-print"
	});
	
	// Onclick Print Button
	$("button.Monthly_ViewTask").click(function(){
		
		var selectedMonth = $(this).closest("div").siblings("table.ViewTimesheetTable").attr("id");
		
		/* var clickedButton = this.id;
		var selectedMonthSummary = $(this).closest("div").siblings("table.TotalSummary").attr("id");
		
	    var xml = "<DailyTasks>";
	  	
	    // Month of the button being clicked 
	    xml += "<Month>" + selectedMonth.substr(0, selectedMonth.length - 15) + "</Month>"
	    
	    // User Details
	    xml += "<UserDetails>";
	    
	    xml += "<Username>" + $("#GenInfo_Username").text() + "</Username>"
	    xml += "<UserID>" + $("#GenInfo_UserID").text() + "</UserID>";
	    xml += "<Email>" + $("#GenInfo_Email").text() + "</Email>";
	    
	    xml += "</UserDetails>";
	    
	    xml += "<Groups>";
	    
	    // Obtaining current user's group
	    $("#UserCurrentGroups li").each(function(){
    		if ($(this).length > 0) {
    			xml += $(this).text() + ","		
    		}
    	});
	    
	    xml+= "</Groups>";
	    
	    xml += "<DailyTask>";
	    
	    // Looping View Timesheet month table to get all daily tasks' details
	    $("#" + selectedMonth + " tbody tr").each(function() {
	        var cells = $("td", this);
	        
	        // If <tr> is not empty
	        if (cells.length > 0) {
	        	
	        	xml += "<date>" + cells.eq(0).text() + "</date>wa";
	        	xml += "<time>" + cells.eq(1).text() + "</time>";
	        	xml += "<projectname>" + cells.eq(2).text() + "</projectname>";
	        	xml += "<tasktype>" + cells.eq(3).text() + "</tasktype>";
	        	xml += "<location>" + cells.eq(4).text() + "</location>";
	        	xml += "<pleasespecify>" + cells.eq(5).text() + "</pleasespecify>";
	        	xml += "<taskdescription>" + cells.eq(6).text() + "</taskdescription>";
	        	xml += "<duration>" + cells.eq(7).text() + "</duration>";
	        	xml += "<transportclaim>" + cells.eq(8).text() + "</transportclaim>";
	        	xml += "<otherclaim>" + cells.eq(9).text() + "</otherclaim>";	    
	        }      	    
	    });
	    
	    xml += "</DailyTask>";
	    
	    xml+= "<TotalSummary>";
	    
	    // Looping View Timesheet month table to get all Total details
	    $("#" + selectedMonthSummary + " tbody tr").each(function() {
	    	var cells = $("td label", this);
	    	
	    	if (cells.length > 0) {
	    		
	    		// The g character means to repeat the search through the entire string
	    		xml += "<" + cells.eq(0).text().replace(/ /g,'') + ">" + cells.eq(1).text() + "</" + cells.eq(0).text().replace(/ /g,'')  + ">";
	    	}
	    });
	    
	    xml+= "</TotalSummary>";  
	    xml += "</DailyTasks>"; */

	    // AJAX event for report generator servlet
	    $.ajax({
	    	type: "POST",
		    url: "DailyTaskReportGenerator",
		    data: {"ReportMonth": selectedMonth.substr(0, selectedMonth.length - 15)},
		    success: function(result){
		    	
		    	// Opening report in a new tab (requires pop-up to be unblock for this site)
		    	window.open(result);
		    },
		    error: function(){
		    	
		    }
	    })
	});
});

//Numbox for Quoted Project Price
$(function(){
    $('.QuotedProjectPrice').NumBox({ 
    	symbol: '', 
    	max: 1000000000,
    	places: 2, 
    	separator: ""
    });	
});

//Archive Group Delete Button
$(function(){
	$("#ArchiveGroupDelete").button({
		icon: "ui-icon-trash"
	});
	
	// Create User Button
	$("#CreateUser").button({
		icon: "ui-icon-squaresmall-plus"
	});
});

//Timepicker 24H format for entries loaded from database
$(function() {
	$("input.time").timepicker({
		"disableTextInput" : true,
		"timeFormat" : "H:i:s"
	});
});

$(function() {
	// Datepicker for entries loaded from database
	$("input.datepicker").datepicker({
		"dateFormat" : "d MM, y"
	});
});

$(function(){
	// Maintain Group Edit Button
	$(".EditButton_Group").button({
		icon: "ui-icon-document"
	});
	
	// Maintain User Edit Button
	$(".EditButton_User").button({
		icon: "ui-icon-document"
	});
	
	// Maintain Group Save Button
	$(".SaveButton_Group").button({
		icon: "ui-icon-disk"
	});
	
	// Maintain Group Save Button
	$(".SaveButton_User").button({
		icon: "ui-icon-disk"
	});
})

$(function(){
	// Menu for administrative tasks
	$("#AdminMenu").menu({
		blur: function( event, ui ) { },
		select: function( event, ui ) {	}
	});
	
	// Event listener - Menu on Blur
	$( "#AdminMenu" ).on( "menublur", function( event, ui ) {
		
	});
	
	// Sub-Menu for administrative tasks
	$(".Menu").menu({});
	
	// Event listener - Menu on Select
	$( "#AdminMenu" ).on ( "menuselect", function( event, ui ) {
		// Handling visibility of UI based on Admin Menu selection
		switch (ui.item.text()) {
		case "Maintain Group":
			// Project Groups
			$("#MaintainGroupDiv").show();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			
			break;
			
		case "Add Group":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").show();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			
			break;
			
		case "Archive Group":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").show();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			
			break;
			
		case "Maintain User":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").show();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			
			break;
			
		case "Add User":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").show();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			break;
		
		case "Archive User":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").show();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").hide();
			
			break;
			
		case "Maintain Project":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").show();
			$("#AddProjectDiv").hide();
			break;
			
		case "Add Project":
			// Project Groups
			$("#MaintainGroupDiv").hide();
			$("#AddGroupDiv").hide();
			$("#ArchiveGroupDiv").hide();
			
			// User Management
			$("#MaintainUserDiv").hide();
			$("#AddUserDiv").hide();
			$("#ArchiveUserDiv").hide();
			
			// Projects
			$("#MaintainProjectDiv").hide();
			$("#AddProjectDiv").show();
			
			break;
		}
	});
	
	// Onclick Logged In User name
	$( ".clickableLabel" ).on( "click", function() {
	    $( "#InfoDialog" ).dialog( "open" );
	  });

	// If Enter Timesheet Save button is clicked
	$("#daily_task_form").submit(function(e){
		e.preventDefault();
		
		if ($("#daily_task_form tbody tr").length > 0) {
			$.ajax({
				type: "POST",
			    url: "SaveTask",
			    data: $("#daily_task_form").serialize(),
			    success: function(result) {
			    	if (result == "ERROR_SAVE_TASK") {
			    		// If Error code has been returned
			    		$("#SaveTaskDiv").removeClass("ui-state-highlight");
			    		$("#SaveTaskDiv").addClass("ui-state-error");
				    	$("#SaveTaskDiv").html("An error occured when saving tasks. Please contact your admin.");
			    	} else {
			    		// If no Error code has been returned (non-zero ID is returned)
			    		$("#SaveTaskDiv").removeClass("ui-state-error");
			    		$("#SaveTaskDiv").addClass("ui-state-highlight");
				    	$("#SaveTaskDiv").html("Daily Task saved successfully.");	
			    	}
			    },
			    error: function () {
			    	$("#SaveTaskDiv").addClass("ui-state-error");
			    	$("#SaveTaskDiv").html("An AJAX error occured when saving tasks. Please contact your admin.");
			    }
			});	
		}
		
		window.scrollTo(0, 0);
	});
	
	// If Add Row button is clicked
	$("#add_button").on("click", function() {
		$("#daily_task tbody").append(
			
			'<tr class="draggable">'
			+
			
			// Delete row button
			'<td ><div ><button type="button" class="delete_row_btn" title="Remove this row"></button></div></td>'
			+
			// Datepicker
			'<td ><input type="text" class="datepicker AlignCenter" name="datepicker" onkeypress="return false" onpaste="return false" required></td>'
			+
			// From and To timepicker
			'<td ><input type="text" class="time AlignCenter" name="from_time" class="SelectMenu" required><br> - <br><input type="text" class="time AlignCenter" name="to_time" required></td>'
			+
			// Droplist for project name
			'<td ><select name="project_name" class="SelectMenu">'
			+ '<c:forEach var="tempProject" items="${projectName}">'
			+ '<option value="${tempProject}"><c:out value="${tempProject}"></c:out></option>'
			+ '</c:forEach>'
			+ '</select></td>'
			+
			// Droplist for task type
			'<td ><select name="task_type" class="SelectMenu">'
			+ '<c:forEach var="tempTask" items="${taskType}">'
			+ '<option value="${tempTask}" ${tempTask == tempDraft.getTaskType()?'selected="selected"': ''}><c:out value="${tempTask}"></c:out></option>'
			+ '</c:forEach>'
			+ '</select></td>'
			+
			// Droplist for location
			'<td ><select class="location SelectMenu" name="location">'
			+ '<option value="Onsite" selected="selected">Onsite</option>'
			+ '<option value="Offsite">Offsite</option>'
			+ '</select><div class="please_specify"><input type="text" class="input_please_specify" name="please_specify" placeholder="Please specify" required></div></td>'
			+
			// Text field for task description & claimable amount
			'<td ><textarea name="task_description" rows="5" cols="30" maxlength="1000" required></textarea></td>'
			+ '<td ><input type="number" name="transportClaimAmount" class="TotalClaimAmount AlignCenter" onpaste="return false">'
			+ '<input type="number" name="otherClaimsAmount" class="TotalClaimAmount AlignCenter" onpaste="return false"></td>'
			+ '</tr>');
					
			// Clearing SaveTask status message
			$("#SaveTaskDiv").removeClass("ui-state-highlight");
			$("#SaveTaskDiv").html("");
			
			// Draggable
			$(function() {
				$(".draggable").draggable({
					connectToSortable : ".sortable",
					opacity : 0.7,
					revert : "invalid",
					scroll : true,
					scrollSensitivity : 100
				});
			});
						
			// Select Menu
			$(function(){
				$(".SelectMenu").selectmenu({
					width: 200
				});
			});
		
			// Datepicker
			$(function() {
				$("input.datepicker").datepicker({
					"dateFormat" : "d MM, y"
				});
			});

			// Timepicker 24H format
			$(function() {
				$("input.time").timepicker({
					"disableTextInput" : true,
					"timeFormat" : "H:i:s"
				});
			});

			// Droplist for Project Name
			$(function() {
				$("").selectmenu();
			});
						
						
			// Numpad for total claimable amount
			$(function () {
			    $('.TotalClaimAmount').NumBox({ 
				   	symbol: '', 
				   	places: 2,
				   	separator: ""
			   	});
			});

			// Delete Button
			$(function() {
				$(".delete_row_btn").button({
					icon: "ui-icon-trash"
				});
			});
			
			// Droplist for location & hide Please specify by default
			$("select.location").on("selectmenuchange", function(event, ui) {
				// Obtaining current selected cell's coordinate
				var table = $("#daily_task tbody")[0];
				var col_index = $(this).parent().index();
				var row_index = $(this).parent().parent().index();
						
				// Only shows Please specify if selection is Onsite, clearing input and hiding placeholder
				if (this.value == "Offsite") {
					//$(table.rows[row_index].cells[col_index]).children("div.please_specify").hide();
					$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").prop("required", false)
					$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").val("Office");
				}
					
				if (this.value == "Onsite") {
					$(table.rows[row_index].cells[col_index]).children("div.please_specify").show();
					$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").val("");
					$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").prop("required", true)
				}
			});
	});
	
	// If delete button is clicked, remove the row
	$(document).on('click', 'button.delete_row_btn', function() {
		$(this).closest('tr').remove();
		
		// Clearing SaveTask status message
		$("#SaveTaskDiv").removeClass("ui-state-highlight");
		$("#SaveTaskDiv").html("");
	});
	
	// Simple table sort
	$(".ViewTimesheetTable").simpleTableSort({
		order : 'asc',
		dynamic : true,
		multiSortStates : false,

		onBeforeSort : function(index) {
			$('#sort-loading').show();
		},

		onAfterSort : function(index) {
			$('#sort-loading').animate({
				opacity : 0
			}, 100, function() {
				$(this).css({
					display : 'none',
					opacity : .5
				});
			});
		}
	});
	
	// Droplist for location & hide Please specify by default
	$("select.location").on("selectmenuchange", function(event, ui) {
		// Obtaining current selected cell's coordinate
		var table = $("#daily_task tbody")[0];
		var col_index = $(this).parent().index();
		var row_index = $(this).parent().parent().index();

		// Only shows Please specify if selection is Onsite, clearing input and hiding placeholder
		if (this.value == "Offsite") {
			//$(table.rows[row_index].cells[col_index]).children("div.please_specify").hide();
			$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").prop("required", false)
			$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input.input_please_specify").val("Office");
		}
		
		if (this.value == "Onsite") {
			$(table.rows[row_index].cells[col_index]).children("div.please_specify").show();
			$(table.rows[row_index].cells[col_index]).children("div.please_specify").children("input_please_specify").prop("required", true)
		}
	});
});
</script>
</head>

<body>
	<div class="ImagePlaceHolder" align="right">
		<img src="${pageContext.request.contextPath}/JSPs/Resources/Common/Trisilco.png">
	</div>

	<div class="dialog" id="InfoDialog" title="Information">
		Hi there! <br>
		You are currently logged in as, 
		<b><span id="GenInfo_Username"><c:out value='${userDetails.getUsername()}'></c:out></span></b> (<b><span id="GenInfo_Email"><c:out value='${userDetails.getEmail()}'></c:out></span></b>), 
		with ID no of, 
		<b><span id="GenInfo_UserID"><c:out value='${userDetails.getUserID()}'></c:out></span></b>. 
		Your assigned group(s) are: <br>
		<ul id="UserCurrentGroups">
			<c:forEach var="tempGroup" items="${userGroup}">
				<li><b><c:out value="${tempGroup}"></c:out></b></li>
			</c:forEach>
		</ul>
	</div>
	
	<table id="headerTable" width="100%">
		<tr>
			<!-- Clickable Label -->
			<td>
				<div id="divDialog">
					<p id="LoggedInAs">
						Logged in as, <span class="clickableLabel" id="ClickableUsername"><u><c:out value='${userDetails.getUsername()}'></c:out></u></span>
					</p>
				</div>
			</td>
			
			<!-- Logout Button -->
			<td class="buttonAlignRightParent">
				<form action="${pageContext.request.contextPath}/Logout" method="post">
					<button id="logOutButton" type="submit"></button>
				</form>
			</td>
		</tr>
	</table>
	
	<div id="tabs">
		<ul>
			<li><a href="#EnterTimesheet">Enter Timesheet</a></li>
			<li><a href="#ViewTimesheet">View Timesheet</a></li>
			<li><a href="#Administration">Administration</a></li>
			<li><a href="#Reporting">Reporting</a></li>
		</ul>
		
		<!--  Tab #1 - For filling in daily task -->
		<div id="EnterTimesheet">
			<!-- Placeholder for status message -->
			<div id="SaveTaskDiv" class="Status_Message"></div>
			
			<br>
			
			<form action="${pageContext.request.contextPath}/SaveTask"
				method="post" id="daily_task_form" name="daily_task_form">
				
				<fieldset>
					<legend>
						Daily Task
					</legend>
					<table id="daily_task" class="daily_task" width="100%">
					
					<!-- Table Headers -->
					<thead>
						<tr>
							<th></th>
							<th>Date</th>
							<th>Time</th>
							<th>Project Name</th>
							<th width="15%">Task Type</th>
							<th>Location</th>
							<th>Task Description</th>
							<th>Transport Claims (RM)<br>Other Claims (RM)</th>
						</tr>
					</thead>

					<!-- Table Body -->
					<tbody class="sortable">
						<c:forEach var="tempDraft" items="${draft_dailyTask}">
							<tr class="draggable">
								<td ><div ><button type="button" class="delete_row_btn" title="Remove this row"></button></div></td>
								<td ><input type="text" class="datepicker AlignCenter" name="datepicker" onkeypress="return false" onpaste="return false" value="${tempDraft.getDate()}" required></td>
								<td >
									<input type="text" class="time AlignCenter" name="from_time" value="${tempDraft.getFrom_time()}" required><br> 
									- <br>
									<input type="text" class="time AlignCenter" name="to_time" value="${tempDraft.getTo_time()}" required>
								</td>
								<td >
									<select name="project_name" class="SelectMenu" >
										<c:forEach var="tempProject" items="${projectName}">
											<option value="${tempProject}" ${tempProject == tempDraft.getProjectName()?'selected="selected"': ''}><c:out value="${tempProject}"></c:out></option>
										</c:forEach>
									</select>
								</td>
								<td  width="15%">
									<select name="task_type" id="task_type" class="SelectMenu">
										<c:forEach var="tempTask" items="${taskType}">
											<option value="${tempTask}" ${tempTask == tempDraft.getTaskType()?'selected="selected"': ''}><c:out value="${tempTask}"></c:out></option>
										</c:forEach>
									</select>
								</td>
								<td >
									<select class="location SelectMenu" name="location">
										<option value="Onsite" ${"Onsite" == tempDraft.getLocation()?'selected="selected"': ''}>Onsite</option>
										<option value="Offsite" ${"Offsite" == tempDraft.getLocation()?'selected="selected"': ''}>Offsite</option>
									</select>
									<div class="please_specify">
										<input type="text" class="input_please_specify" name="please_specify" placeholder="Please specify" value="${tempDraft.getPlease_specify()}" required>
									</div>
								</td>
								<td>
									<textarea name="task_description" rows="5" cols="30" maxlength="1000" required><c:out value="${tempDraft.getTaskDescription()}"></c:out></textarea>
								</td>
								<td >
									<input type="number" name="transportClaimAmount" class="TotalClaimAmount AlignCenter" onpaste="return false" value="${tempDraft.getTransportClaimAmount()}"/>
									<input type="number" name="otherClaimsAmount" class="TotalClaimAmount AlignCenter" onpaste="return false" value="${tempDraft.getOtherClaimAmount()}"/>
								</td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</fieldset>
				<button type="submit" id="save_button" name="butt_save" class="button_style" title="Save all current entries">Save</button><button type="button" id="add_button" name="add_button" class="button_style" title="Add new row of daily task entry">Add</button>
			</form>
		</div>
		
		<!-- Tab #2 - For viewing monthly daily task -->
		<div id="ViewTimesheet">
			<div id="months">
				<c:forEach var="tempMonth" items="${months}">
					<h3>
						<c:out value="${tempMonth}"></c:out>
					</h3>
					<div>
						<c:set var="dailyTaskTableID" value="${tempMonth}_dailyTaskTable"></c:set>
						<table id="${dailyTaskTableID}" class="ViewTimesheetTable daily_task" width="100%" border=0>
							<thead>
								<tr>
									<th class="sort-date">Date </th>
									<th>Time</th>
									<th class="sort-alphabetical">Project Name</th>
									<th class="sort-alphabetical">Task Type</th>
									<th>Location</th>
									<th>Please Specify</th>
									<th>Task Description</th>
									<th class="sort-numeric">Duration (Hours)</th>
									<th class="sort-numeric">Transport Claim(RM)</th>
									<th class="sort-numeric">Other Claim(RM)</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="totalDurations" value="${0}"></c:set>
								<c:set var="totalTransportClaim" value="${0}"></c:set>
								<c:set var="totalOtherClaim" value="${0}"></c:set>
								
								<c:forEach var="tempEntry" items="${dailyTask}">
									<c:if test="${tempEntry.getSubmissionMonth()==tempMonth}">
										<tr>
											<td width="8%"><c:out value="${tempEntry.getDate()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getFrom_time()}"></c:out> - <c:out value="${tempEntry.getTo_time()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getProjectName()}"></c:out></td>
											<td width="8%%"><c:out value="${tempEntry.getTaskType()}"></c:out></td>
											<td width="6%"><c:out value="${tempEntry.getLocation()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getPlease_specify()}"></c:out></td>
											<td width="18%%"><c:out value="${tempEntry.getTaskDescription()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getDuration()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getTransportClaimAmount()}"></c:out></td>
											<td width="10%"><c:out value="${tempEntry.getOtherClaimAmount()}"></c:out></td>
											
											<!-- Accumulation of Durations & Claim Amounts -->
											<c:set var="totalDurations" value="${totalDurations + tempEntry.getDuration()}"></c:set>
											<c:set var="totalTransportClaim" value="${totalTransportClaim + tempEntry.getTransportClaimAmount()}"></c:set>
											<c:set var="totalOtherClaim" value="${totalOtherClaim + tempEntry.getOtherClaimAmount()}"></c:set>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
						<br>
						<c:set var="totalSummaryTableID" value="${tempMonth}_summaryTable"></c:set>
						<table id="${totalSummaryTableID}" class="TotalSummary" border=0>
							<tr>
								<td><b><label>Total Duration</label></b></td>
								<td>: <label><c:out value="${totalDurations}"></c:out></label> Hours</td>
							</tr>
							<tr>
								<td><label><b>Total Transport Claims</b></label></td>
								<td>: RM <label><c:out value="${totalTransportClaim}"></c:out></label></td>
							</tr>
							<tr>
								<td><label><b>Total Other Claims</b></label></td>
								<td>: RM <label><c:out value="${totalOtherClaim}"></c:out></label></td>
							</tr>
						</table>
						<div align="right">
							<c:set var="buttonID" value="${tempMonth}_button"></c:set>
							<button id="${buttonID}" class="Monthly_ViewTask">Print</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		
		<!-- Tab #3 - For administrative tasks -->
		<div id="Administration">
			<table width="100%">
				<tr>
					<td height="500"width="15%" valign="top">
						<ul id="AdminMenu" class="Menu MenuFont">
							<li>
								<div><span class="ui-icon ui-icon-suitcase"></span>Project Groups</div>
									<ul class="Menu MenuFont">
										<li><div><span class="ui-icon ui-icon-wrench"></span>Maintain Group</div></li>	
										<li><div><span class="ui-icon ui-icon-circle-plus"></span>Add Group</div></li>
										<li><div><span class="ui-icon ui-icon-circle-minus"></span>Archive Group</div></li>
									</ul>
								</li>
							<li>
								<div><span class="ui-icon ui-icon-person"></span>User Management</div>
								<ul class="Menu MenuFont">
									<li><div><span class="ui-icon ui-icon-pencil"></span>Maintain User</div></li>
									<li><div><span class="ui-icon ui-icon-plusthick"></span>Add User</div></li>
									<li><div><span class="ui-icon ui-icon-minusthick"></span>Archive User</div></li>
								</ul>
							</li>
							<li>
								<div><span class="ui-icon ui-icon-folder-open"></span>Projects</div>
								<ul class="Menu MenuFont">
									<li><div><span class="ui-icon ui-icon-search"></span>Maintain Project</div></li>
									<li><div><span class="ui-icon ui-icon-plus"></span>Add Project</div></li>
								</ul>
							</li>
						</ul>
					</td>
					<td height="500" width="85%" valign="top">
					
						<!-- Project Groups: Maintain Group -->
						<div id="MaintainGroupDiv" hidden>
							<%@ include file="SubJSPs/MaintainGroup.jsp" %>
						</div>
						
						<!-- Project Groups: Add Group -->
						<div id="AddGroupDiv" hidden>
							<%@ include file="SubJSPs/AddGroup.jsp" %>
						</div>
						
						<!-- Project Groups: Archive Group -->
						<div id="ArchiveGroupDiv" hidden>
							<%@ include file="SubJSPs/ArchiveGroup.jsp" %>
						</div>
						
						<!-- User Management: Maintain User -->
						<div id="MaintainUserDiv" hidden>
							<%@ include file="SubJSPs/MaintainUser.jsp" %>
						</div>
						
						<!-- User Management: Add User -->
						<div id="AddUserDiv" hidden>
							<%@ include file="SubJSPs/AddUser.jsp" %>
						</div>
						
						<!-- User Management: Archive User -->
						<div id="ArchiveUserDiv" hidden>
							<%@ include file="SubJSPs/ArchiveUser.jsp" %>
						</div>
						
						<!-- Projects: Maintain Project -->
						<div id="MaintainProjectDiv" hidden>
							<%@ include file="SubJSPs/MaintainProject.jsp" %>
						</div>
						
						<!-- Projects: Add Project -->
						<div id="AddProjectDiv" hidden>
							<%@ include file="SubJSPs/AddProject.jsp" %>
						</div>
					</td>
				</tr>
			</table>	
		</div>
		
		<!-- Tab #4 - For reporting purposes -->
		<div id="Reporting">
			<h1>Nothing to see here :)</h1>
		</div>
	</div>
</body>

<footer>
	<jsp:include page="/JSPs/Footer.jsp"></jsp:include>
</footer>
</html>