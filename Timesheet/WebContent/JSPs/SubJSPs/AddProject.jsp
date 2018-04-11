<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="US-ASCII"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
</head>

<!-- jQuery -->
<script type="text/javascript">
$(function(){
	// If Add New Project button is clicked
	$("#AddNewProject_form").submit(function(e){
		e.preventDefault();

		$.ajax({
			type: "POST",
		    url: "AddNewProject",
		    data: $("#AddNewProject_form").serialize(),
		    success: function(result) {
		    	if (result == "ERROR_ADD_PROJECT") {
		    		$("#AddProjectDiv_Status").removeClass("ui-state-highlight");
		    		$("#AddProjectDiv_Status").addClass("ui-state-error");
			    	$("#AddProjectDiv_Status").html("An error has occured when creating new project. Please contact admin.");
		    	} else {
		    		$("#AddProjectDiv_Status").removeClass("ui-state-error");
		    		$("#AddProjectDiv_Status").addClass("ui-state-highlight");
			    	$("#AddProjectDiv_Status").html("A new project has been created successfully.");

			    	// Clearing all inputs after successful AJAX
			    	$("#ProjectName_id").val("");
			    	$("#ProjectDescription_id").val("");
			    	$("#QuotedDuration_id").val(0);
			    	$("#QuotedProjectPrice_id").val(0);
			    	$("#KickOffDate_id").val("");
			    	$("#SITDeliveryDate_id").val("");
			    	$("#UATDeliveryDate_id").val("");
			    	$("#GoLiveDeliveryDate_id").val("");
		    	}	
		    },
		    error: function () {
		    	$("#AddProjectDiv_Status").addClass("ui-state-error");
		    	$("#AddProjectDiv_Status").html("An AJAX error has occured when creating new project. Please contact admin.");
		    }
		});
		
		window.scrollTo(0, 0);
	});
});
</script>

<body>
	<div id="AddProjectDiv_Status" class="Status_Message"></div>

	<h3>Project Information</h3>

	<form action="${pageContext.request.contextPath}/AddNewProject"
		id="AddNewProject_form" method="post">

		<fieldset>
			<legend>Details</legend>
			<table class="daily_task" width="100%">
				<thead>
					<tr>
						<th width="30%"></th>
						<th width="70%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Project Name</td>
						<td><input type="text" id="ProjectName_id" name="ProjectName"
							size="69" class="AlignCenter" required></td>
					</tr>
					<tr>
						<td>Project Description</td>
						<td><textarea id="ProjectDescription_id"
								name="ProjectDescription" rows="5" cols="70" maxlength="1000"
								required></textarea></td>
					</tr>
					<tr>
						<td>Client's Name</td>
						<td><select class="SelectMenu" name="ClientID">
								<c:forEach var="tempCust" items="${allCustomers}">
									<option value="${tempCust.getCustomerID()}"><c:out value="${tempCust.getCustomerName()}"></c:out></option>
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>Assigned Project Group</td>
						<td><select class="SelectMenu" name="AssignedProjectID">
								<c:forEach var="tempGroup" items="${allGroups}">
									<option value="${tempGroup.getGroupID()}"><c:out value="${tempGroup.getGroupName()}"></c:out></option>
								</c:forEach>
						</select></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<br>

		<fieldset>
			<legend>Budget</legend>
			<table class="daily_task" width="100%">
				<thead>
					<tr>
						<th width="30%"></th>
						<th width="70%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Quoted Durations (days)</td>
						<td><input type="text" id="QuotedDuration_id"
							name="QuotedDuration" size="69" class="AlignCenter"
							onkeypress="return isNumberKey(event)" onpaste="return false"
							required></td>
					</tr>
					<tr>
						<td>Quoted Project Price (RM)</td>
						<td><input type="number" id="QuotedProjectPrice_id"
							name="QuotedProjectPrice" size="69"
							class="AlignCenter QuotedProjectPrice" required></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<br>

		<fieldset>
			<legend>Milestone</legend>
			<table class="daily_task" width="100%">
				<thead>
					<tr>
						<th width="30%"></th>
						<th width="70%"></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Kick-Off Date</td>
						<td><input type="text" id="KickOffDate_id" name="KickOffDate"
							size="69" class="AlignCenter datepicker"
							onkeypress="return false" onpaste="return false" required>
						</td>
					</tr>
					<tr>
						<td>Proposed SIT Date</td>
						<td><input type="text" id="SITDeliveryDate_id"
							name="SITDeliveryDate" size="69" class="AlignCenter datepicker"
							onkeypress="return false" onpaste="return false" required>
						</td>
					</tr>
					<tr>
						<td>Proposed UAT Date</td>
						<td><input type="text" id="UATDeliveryDate_id"
							name="UATDeliveryDate" size="69" class="AlignCenter datepicker"
							onkeypress="return false" onpaste="return false" required>
						</td>
					</tr>
					<tr>
						<td>Proposed GoLive Date</td>
						<td><input type="text" id="GoLiveDeliveryDate_id"
							name="GoLiveDeliveryDate" size="69"
							class="AlignCenter datepicker" onkeypress="return false"
							onpaste="return false" required></td>
					</tr>
				</tbody>
			</table>
		</fieldset>
		<br>

		<div>
			<button class="create_project_button" type="submit">Create</button>
		</div>
	</form>
</body>
</html>