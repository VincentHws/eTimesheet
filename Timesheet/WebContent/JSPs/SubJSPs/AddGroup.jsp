<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>

<!-- jQuery -->
<script type="text/javascript">
$(function(){
	// OnFocus, clear Add Group Status Message
	$("#AddGroupName_Input").on("click", function(){
		var div = $("#AddGroupDiv_Status");
		
		// If there is status message clear it and change class 
		if (div.text() != ""){
			$("#AddGroupDiv_Status").html("");
			$("#AddGroupDiv_Status").removeClass("ui-state-highlight");
		} 
	});
	
	// OnFocus, clear Add Group Status Message
	$("#AddGroupDescription_Input").on("click", function(){
		var div = $("#AddGroupDiv_Status");
		
		// If there is status message clear it and change class 
		if (div.text() != ""){
			$("#AddGroupDiv_Status").html("");
			$("#AddGroupDiv_Status").removeClass("ui-state-highlight");
		} 
	});
	
	// If Add Group Button is clicked
	$("#AddGroupForm").submit(function(e){
		e.preventDefault();
		
		$.ajax({
			type: "POST",
		    url: "AddNewGroup",
		    data: $("#AddGroupForm").serialize(),
		    success: function(result) {
		    	if (result == "ERROR_ADD_GROUP") {
		    		// If Error code has been returned
		    		$("#AddGroupDiv_Status").removeClass("ui-state-highlight");
		    		$("#AddGroupDiv_Status").addClass("ui-state-error");
			    	$("#AddGroupDiv_Status").html("An error occured when adding new group. Please contact your admin.");  
		    	} else {
		    		// If no Error code has been returned (non-zero ID is returned)
		    		$("#AddGroupDiv_Status").removeClass("ui-state-error");
			    	$("#AddGroupDiv_Status").addClass("ui-state-highlight");
			    	$("#AddGroupDiv_Status").html("New group has been added successfully with ID - <" + result + ">");
	    	
			    	// Appending newly added group into Maintain Group table
			    	$("#AllGroupDetails tbody").append(
			    		"<tr>" +
						'<td><textarea name="groupID" class="SerializeForm" rows="1" cols="5" disabled required>' + result + "</textarea></td>" +
						'<td><textarea name="groupName" class=" SerializeForm EditableTextArea" rows="1" cols="20" maxlength=45" required disabled=false>' + $("#AddGroupName_Input").val() + '</textarea></td>' +
						'<td><textarea name="groupDescription" class="SerializeForm EditableTextArea" rows="3" cols="100" maxlength="1000" disabled=false required>' + $("#AddGroupDescription_Input").val() + '</textarea></td>' +
						"</tr>"
			    	);
			    	
			    	// Appending newly added group into Archive Group table
			    	$("#ArchiveGroupTable tbody").append(
			    		"<tr>" +
						"<td><input type='checkbox'></td>" + 
						"<td>" + result + "</td>" +
						"<td>" + $("#AddGroupName_Input").val() + "</td>" +
						"<td>" + $("#AddGroupDescription_Input").val() + "</td>" +
						"</tr>"
			    	);
			    	
			    	// Clearing Add Group inputs
			    	$("#AddGroupName_Input").val("");
			    	$("#AddGroupDescription_Input").val("");
		    	}
		    },
		    error: function (result) {
		    	// If AJAX encounters error
	    		$("#AddGroupDiv_Status").addClass("ui-state-error");
		    	$("#AddGroupDiv_Status").html("An AJAX error occured when adding new group. Please contact your admin."); 
		    }
		});	
	});
});
</script>

</head>
<body>
	<div id="AddGroupDiv_Status" class="Status_Message"></div>
	<br>
	<fieldset>
		<legend>Group Details</legend>
		<form id="AddGroupForm"
			action="${pageContext.request.contextPath}/AddNewGroup" method="post">
			<table id="AddGroup" class="daily_task" width="100%" border="0">
				<thead>
					<tr>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Group Name:</td>
						<td><input id="AddGroupName_Input" class="AlignCenter"
							type="text" size="49" name="AddGroupName" required></td>
					</tr>
					<tr>
						<td>Group Description:</td>
						<td><textarea id="AddGroupDescription_Input"
								class="AlignCenter" name="AddGroupDescription" rows="3"
								cols="50" maxlength="1000" required></textarea></td>
					</tr>
				</tbody>
			</table>
			<br>
			<button type="submit" id="AddGroupButton">Add</button>
		</form>
	</fieldset>
</body>
</html>