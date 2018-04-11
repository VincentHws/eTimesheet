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
	// If Add User Create button is clicked
	$("#AddUserForm").submit(function(e){
		e.preventDefault();

		// If at least 1 checkbox is ticked
		if($("td.AssignedGroup label").filter(":has(:checkbox:checked)").length > 0) {
			
			// Clearing checkbox td cell's highlight
			$("#Checkbox_td").removeClass("ui-state-highlight");
			
			$.ajax({
				type: "POST",
			    url: "AddNewUser",
			    data: $("#AddUserForm").serialize(),
			    success: function(result) {
			    	if (result == "ERROR_ADD_USER") {
			    		$("#AddUserDiv_Status").removeClass("ui-state-highlight");
			    		$("#AddUserDiv_Status").addClass("ui-state-error");
				    	$("#AddUserDiv_Status").html("An error occured when adding new user. Please contact your admin.");
			    	} else {
			    		$("#AddUserDiv_Status").removeClass("ui-state-error");
			    		$("#AddUserDiv_Status").addClass("ui-state-highlight");
				    	$("#AddUserDiv_Status").html("User added successfully. ");
	
				    	// Clearing all inputs after successful AJAX
				    	$("#AddUser_Username").val("");
				    	$("#AddUser_Password").val("");
				    	$("#AddUser_Email").val("");
				    	
				    	$("td.AssignedGroup label").filter(":has(:checkbox:checked)").each(function(){
			    			
			    			// Unchecking checkbox when Cancel is clicked
			    			$(this).children().prop("checked", false);
				    	});
			    	}
			    },
			    error: function () {
			    	$("#AddUserDiv_Status").addClass("ui-state-error");
			    	$("#AddUserDiv_Status").html("An AJAX error occured when adding new user. Please contact your admin.");
			    }
			});	
			
			window.scrollTo(0, 0);
		} else {
			// Highlight checkbox td cell
			$("#Checkbox_td").addClass("ui-state-highlight");
		}
	});
	
	// OnFocus, clear Add New User Status Message
	$("#AddUser_Username").on("click", function(){
		var div = $("#AddUserDiv_Status");
		
		// If there is status message clear it and change class 
		if (div.text() != ""){
			$("#AddUserDiv_Status").html("");
			$("#AddUserDiv_Status").removeClass("ui-state-highlight");
		} 
	});
	
	$("#AddUser_Password").on("click", function(){
		var div = $("#AddUserDiv_Status");
		
		// If there is status message clear it and change class 
		if (div.text() != ""){
			$("#AddUserDiv_Status").html("");
			$("#AddUserDiv_Status").removeClass("ui-state-highlight");
		} 
	});
	
	$("#AddUser_Email").on("click", function(){
		var div = $("#AddUserDiv_Status");
		
		// If there is status message clear it and change class 
		if (div.text() != ""){
			$("#AddUserDiv_Status").html("");
			$("#AddUserDiv_Status").removeClass("ui-state-highlight");
		} 
	});
});
</script>

</head>
<body>
	<div id="AddUserDiv_Status" class="Status_Message"></div>
	<br>
	<form id="AddUserForm" name="AddUserForm"
		action="${pageContext.request.contextPath}/AddUser" method="post">
		<fieldset>
			<legend>Create User</legend>
			<table class="daily_task" id="AddUserTable_PeronalInfo" width="100%">
				<thead>
					<tr>
						<th width="30%"></th>
						<th width="70%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Username</td>
						<td align="left"><input type="text" id="AddUser_Username"
							name="AddUser_Username" class="AlignCenter" size="50" required>
						</td>
					</tr>
					<tr>
						<td>Password</td>
						<td align="left"><input type="text" id="AddUser_Password"
							name="AddUser_Password" class="AlignCenter" size="50" required>
						</td>
					</tr>
					<tr>
						<td>Email</td>
						<td align="left"><input type="text" id="AddUser_Email"
							name="AddUser_Email" class="AlignCenter" size="50" required>
						</td>
					</tr>
					<tr>
						<td>Assigned Group(s)</td>
						<td align="left" class="AssignedGroup" id="Checkbox_td"><c:forEach
								var="tempGroup" items="${allGroups}">
								<label><input type="checkbox" name="AddUser_Group"
									value="${tempGroup.getGroupID()}">
								<c:out value="${tempGroup.getGroupName()}"></c:out></label>
								<br>
							</c:forEach></td>
					</tr>
				</tbody>
			</table>
			<br>
			<button type="submit" id="CreateUser">Create</button>
		</fieldset>
	</form>
</body>
</html>