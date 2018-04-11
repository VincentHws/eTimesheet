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
	//Archive Group List Dialog
	$(".ArchiveGroup").dialog({
		resizable: false,
		height: "auto",
		width: "auto",
		modal: true,
	    autoOpen: false,
	    show: {
	      effect: "fold",
	      duration: 300
	    },
	    hide: {
	      effect: "explode",
	      duration: 400
	    },
	    buttons: {
	        "Confirm": function() {
	        	var checkedGroupID = "";
	        	
	        	$("#ArchiveGroupTable tbody tr").filter(":has(:checkbox:checked)").each(function() {
	    	        // $(this) represents all <tr> with ticked checkbox
	    			$tr = $(this);
	    			
	    			// Appending ticked group(s) into list
	    			if (checkedGroupID == "") {
	    				checkedGroupID = checkedGroupID + $tr.find("td").eq(1).text();
	    			} else {
	    				checkedGroupID = checkedGroupID + "|" + $tr.find("td").eq(1).text();
	    			}			
	    	    });	
	        	
	        	$.ajax({
	        		type: "POST",
				    url: "ArchiveGroup",
				    data: {"checkedGroupIDList": checkedGroupID},
				    success: function(result) {
				    	if (result == "ERROR_ARCHIVE_GROUP") {
				    		// If error code has been returned 
				    		$("#ArchiveGroupDiv_Status").removeClass("ui-state-highlight");
				    		$("#ArchiveGroupDiv_Status").addClass("ui-state-error");
					    	$("#ArchiveGroupDiv_Status").html("An error has occured when archiving group(s). Please contact your admin.");
				    	} else {
				    		// If no error code has been returned 
				    		$("#ArchiveGroupDiv_Status").removeClass("ui-state-error");
				    		$("#ArchiveGroupDiv_Status").addClass("ui-state-highlight");
					    	$("#ArchiveGroupDiv_Status").html("Group(s) archived successfully.");
					    
					    	// Removing checked entries from ArchiveGroupTable
					    	$("#ArchiveGroupTable tbody tr").filter(":has(:checkbox:checked)").each(function() {
				    	        // $(this) represents all <tr> with ticked checkbox
				    			$tr = $(this);
	
				    			// Removing checked entries from AllGroupDetails table
				    	        $("#AllGroupDetails tbody tr").each(function() {
				    	        	// $(this) represents all <tr> on maintain group
				    	        	$tr_AllGroupDetail = $(this);

				    	        	// Comparing group ID of checked group against AllGroupDetails table
				    	        	if($tr_AllGroupDetail.find("td").eq(0).text() == $tr.find("td").eq(1).text()) {
				    	        		$tr_AllGroupDetail.remove();
				    	        	}
				    	        });
				    	        
				    			$tr.remove();
				    	    });
				    	}
				    },
				    error: function () {
				    	$("#ArchiveGroupDiv_Status").addClass("ui-state-error");
				    	$("#ArchiveGroupDiv_Status").html("An AJAX error has occured when archiving group(s). Please contact your admin.");
				    }
	        	});
	        	
	        	$(this).dialog("close");
	        },      
	        Cancel: function() {
	        	$("#ArchiveGroupTable tbody tr").filter(":has(:checkbox:checked)").each(function() {
	    	        // $(this) represents all <tr> with ticked checkbox
	    			$tr = $(this);
	    			
	    			// Unchecking checkbox when Cancel is clicked
	    			$tr.find("td").eq(0).children().prop("checked", false);
	    	    });
	        	
	          $(this).dialog("close");
	        }
	    }
	});
	
	// If Archive Group Button is clicked
	$("#ArchiveGroupDelete").on("click", function(checkedGroups) {
		checkedGroups = "";
		
		// Clearing current content from <ul>
		$("#ArchiveGroupsList").empty();
		
		// If something has been checked
		if($("#ArchiveGroupTable tbody tr").filter(":has(:checkbox:checked)").length > 0) {
			$("#ArchiveGroupTable tbody tr").filter(":has(:checkbox:checked)").each(function() {
		        // $(this) represents all <tr> with ticked checkbox
				$tr = $(this);
		 
		        // Appending ticked group(s) into list
				$("#ArchiveGroupsList").append("<li>" +  $tr.find("td").eq(2).text() + "</li>")		
		    });	
			
			$("#ArchiveGroupsDialog").dialog("open");	
		}
	});
});
</script>

</head>
<body>
	<div id="ArchiveGroupDiv_Status" class="Status_Message"></div>
	<br>
	<table class="daily_task" id="ArchiveGroupTable" width="100%">
		<thead>
			<tr>
				<th></th>
				<th>ID</th>
				<th>Group Name</th>
				<th>Group Description</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="tempGroup" items="${allGroups}">
				<tr>
					<td><input type="checkbox"></td>
					<td><c:out value="${tempGroup.getGroupID()}"></c:out></td>
					<td><c:out value="${tempGroup.getGroupName()}"></c:out></td>
					<td><c:out value="${tempGroup.getGroupDescription()}"></c:out></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<br>
	<button type="button" id="ArchiveGroupDelete"></button>

	<!-- Dialog for archive group confirmation -->
	<div class="ArchiveGroup" id="ArchiveGroupsDialog" title="Important">
		The following group(s) will be removed: <br>
		<ul id="ArchiveGroupsList">

		</ul>
		Do you want to proceed?
	</div>
</body>
</html>