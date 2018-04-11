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
	// Onclick Maintain User Save Button
	$("#AllUserDetails_form").submit(function(e){
		e.preventDefault();
		
		// Temporary enabling textarea fields for AJAX serialization
		$("textarea.SerializeForm").prop("disabled", false);
		
		$.ajax({
			type: "POST",
		    url: "MaintainUser",
		    data: $("#AllUserDetails_form").serialize(),
		    success: function(result) {
		    	if (result == "ERROR_MAINTAIN_GROUP") {
		    		// If Error code has been returned
		    		$("#MaintainUserDiv_Status").removeClass("ui-state-highlight");
		    		$("#MaintainUserDiv_Status").addClass("ui-state-error");
			    	$("#MaintainUserDiv_Status").html("An error occured when updating user details. Please contact your admin.");
		    	} else {
		    		// If no Error code has been returned (non-zero ID is returned)
		    		$("#MaintainUserDiv_Status").removeClass("ui-state-error");
		    		$("#MaintainUserDiv_Status").addClass("ui-state-highlight");
			    	$("#MaintainUserDiv_Status").html("User details updated successfully.");	
		    	}
		    },
		    error: function(result){
		    	$("#MaintainUserDiv_Status").addClass("ui-state-error");
		    	$("#MaintainUserDiv_Status").html("An AJAX error occured when updating user details. Please contact your admin.");
		    },
		    complete: function(){
		    	// Disabling textarea fields after AJAX
		    	$("textarea.SerializeForm").prop("disabled", true);
		    }
		})
	});
	
	// Edit & Save Button On Click
	// Toogle between disabled / enabled for Maintain user table
	$(".EditButton_User").on("click", function(){
		// Clearing MaintainGroupDiv status message
		$("#MaintainUserDiv_Status").removeClass("ui-state-highlight");	
		$("#MaintainUserDiv_Status").html("");	
		
		if ($("#AllUserDetails tbody tr textarea.EditableTextArea").prop("disabled") == true) {
			$("#AllUserDetails tbody tr textarea.EditableTextArea").prop("disabled", false);
			
			// Hiding Save Button
			$(".SaveButton_User").hide();
			
			// Reinitialize Edit Button to cater changing of button text and icon
			$(".EditButton_User").html("Done");
			$(".EditButton_User").button("destroy");
			$(".EditButton_User").button({
				icon: "ui-icon-circle-check"
			});
		} else {
			$("#AllUserDetails tbody tr textarea.EditableTextArea").prop("disabled", true);
			
			// Showing Save Button
			$(".SaveButton_User").show();
			
			// Reinitialize Edit Button to cater changing of button text and icon
			$(".EditButton_User").html("Edit");
			$(".EditButton_User").button("destroy");
			$(".EditButton_User").button({
				icon: "ui-icon-document"
			});
		}
	});
	
	// To filter Maintain User table based on user input
	$("#MaintainUserSearch").on("keyup", function() {
	    var value = $(this).val().toLowerCase();
	    $("#AllUserDetails tbody tr").filter(function() {
	      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
	    });
	  });
});
</script>

</head>
<body>
	<div id="MaintainUserDiv_Status" class="Status_Message"></div>

	<!-- Empty Placeholder -->
	<div>
		<h1></h1>
	</div>

	<input type="text" id="MaintainUserSearch" placeholder="Search"
		size="20"></input>

	<!-- Empty Placeholder -->
	<div>
		<h1></h1>
	</div>

	<form action="${pageContext.request.contextPath}/MaintainUser"
		method="post" id="AllUserDetails_form">
		<div>
			<button type="button" class="EditButton_User">Edit</button>
			<button type="submit" class="SaveButton_User">Save</button>
		</div>

		<br>

		<table id="AllUserDetails" class="daily_task" width="100%">
			<thead>
				<tr>
					<th width="10%">ID</th>
					<th width="30%">Username</th>
					<th width="30%">Password</th>
					<th width="30%">Email</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tempUser" items="${allUsers}">
					<tr>
						<td><textarea class="SerializeForm" name="userID" rows="1"
								cols="5" disabled required><c:out value="${tempUser.getUserID()}"></c:out></textarea></td>
						<td><textarea class="EditableTextArea SerializeForm"
								name="userName" rows="1" cols="30" maxlength="45" disabled
								required><c:out value="${tempUser.getUsername()}"></c:out></textarea></td>
						<td><textarea class="EditableTextArea SerializeForm"
								name="password" rows="1" cols="30" maxlength="45" disabled
								required><c:out value="${tempUser.getPassword()}"></c:out></textarea></td>
						<td><textarea class="EditableTextArea SerializeForm"
								name="userEmail" rows="1" cols="40" maxlength="45" disabled
								required><c:out value="${tempUser.getEmail()}"></c:out></textarea></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</form>
</body>
</html>