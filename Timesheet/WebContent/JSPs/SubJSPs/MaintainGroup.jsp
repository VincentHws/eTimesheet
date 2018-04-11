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
	// Onclick Maintain Group Save Button
	$("#AllGroupDetails_form").submit(function(e){
		e.preventDefault();
		
		// Temporary enabling textarea fields for AJAX serialization
		$("textarea.SerializeForm").prop("disabled", false);
		
		$.ajax({
			type: "POST",
		    url: "MaintainGroup",
		    data: $("#AllGroupDetails_form").serialize(),
		    success: function(result) {
		    	if (result == "ERROR_MAINTAIN_GROUP") {
		    		// If Error code has been returned
		    		$("#MaintainGroupDiv_Status").removeClass("ui-state-highlight");
		    		$("#MaintainGroupDiv_Status").addClass("ui-state-error");
			    	$("#MaintainGroupDiv_Status").html("An error occured when updating group details. Please contact your admin.");
		    	} else {
		    		// If no Error code has been returned (non-zero ID is returned)
		    		$("#MaintainGroupDiv_Status").removeClass("ui-state-error");
		    		$("#MaintainGroupDiv_Status").addClass("ui-state-highlight");
			    	$("#MaintainGroupDiv_Status").html("Group details updated successfully.");	
		    	}
		    },
		    error: function(result){
		    	$("#MaintainGroupDiv_Status").addClass("ui-state-error");
		    	$("#MaintainGroupDiv_Status").html("An AJAX error occured when updating group details. Please contact your admin.");
		    },
		    complete: function(){
		    	// Disabling textarea fields after AJAX
		    	$("textarea.SerializeForm").prop("disabled", true);
		    }
		})
	});
	
	// Edit & Save Button On Click
	// Toogle between disabled / enabled for Maintain group table
	$(".EditButton_Group").on("click", function(){
		// Clearing MaintainGroupDiv status message
		$("#MaintainGroupDiv_Status").removeClass("ui-state-highlight");	
		$("#MaintainGroupDiv_Status").html("");	
		
		if ($("#AllGroupDetails tbody tr textarea.EditableTextArea").prop("disabled") == true) {
			$("#AllGroupDetails tbody tr textarea.EditableTextArea").prop("disabled", false);
			
			// Hiding Save Button
			$(".SaveButton_Group").hide();
			
			// Reinitialize Edit Button to cater changing of button text and icon
			$(".EditButton_Group").html("Done");
			$(".EditButton_Group").button("destroy");
			$(".EditButton_Group").button({
				icon: "ui-icon-circle-check"
			});
		} else {
			$("#AllGroupDetails tbody tr textarea.EditableTextArea").prop("disabled", true);
			
			// Showing Save Button
			$(".SaveButton_Group").show();
			
			// Reinitialize Edit Button to cater changing of button text and icon
			$(".EditButton_Group").html("Edit");
			$(".EditButton_Group").button("destroy");
			$(".EditButton_Group").button({
				icon: "ui-icon-document"
			});
		}
	});
	
	// To filter Maintain Group table based on user input
	$("#MaintainGroupSearch").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#AllGroupDetails tbody tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	 });
});
</script>
</head>
<body>
	<div id="MaintainGroupDiv_Status" class="Status_Message"></div>

	<br>

	<input type="text" id="MaintainGroupSearch" placeholder="Search" size="20"></input>
	
	<br>

	<form action="${pageContext.request.contextPath}/MaintainGroup"
		method="post" id="AllGroupDetails_form">

		<br>
		
		<div>
			<button type="button" class="EditButton_Group">Edit</button>
			<button type="submit" class="SaveButton_Group">Save</button>
		</div>

		<br>

		<!-- Table to display all existing groups -->
		<table id="AllGroupDetails" class="daily_task" width="100%">
			<thead>
				<tr>
					<th width="5%">ID</th>
					<th width="25%">Name</th>
					<th width="70%">Description</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tempGroup" items="${allGroups}">
					<tr>
						<td>
							<textarea class="SerializeForm" name="groupID" rows="1" cols="5" disabled><c:out value="${tempGroup.getGroupID()}"></c:out></textarea>
						</td>
						<td>
							<textarea class="EditableTextArea SerializeForm" name="groupName"  rows="0" cols="20" maxlength="45" disabled required><c:out value="${tempGroup.getGroupName()}"></c:out></textarea>
						</td>
						<td>
							<textarea class="EditableTextArea SerializeForm" name="groupDescription"  rows="3" cols="100" maxlength="1000" disabled required><c:out value="${tempGroup.getGroupDescription()}"></c:out></textarea>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</body>
</html>