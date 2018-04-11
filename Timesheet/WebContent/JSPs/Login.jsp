<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>TRISILCO Timesheet</title>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="icon" href="JSPs/Resources/Common/Trisilco-Logo.png">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/Login/Login.css">
<link rel="stylesheet" type="text/css" href="JSPs/Resources/jQuery.ui/jquery-ui.css">

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- jQuery -->
<script>
$(function(){
	$("#butt_login").button({
		icon: "ui-icon-locked"
	});
});
</script>
</head>
<body>
	<div align="right">
		<img src="${pageContext.request.contextPath}/JSPs/Resources/Common/Trisilco.png">
	</div>
	
	<!-- Empty Placeholder -->
	<div>
		<h1></h1>
	</div>
	
	<div>
		<form action="${pageContext.request.contextPath}/Home"
			method="post" id="login_form" name="login_form">
			<fieldset>
				<legend>Login</legend>
				<table>
					<tr>
						<td>
							<table>
								<!-- Username  -->
								<tr>
									<td>Username:</td>
								</tr>
								<tr>
									<td><input type="text" name="text_login_username" required></td>
								</tr>
								<!-- Password  -->
								<tr>
									<td>Password:</td>
								</tr>
								<!-- Button -->
								<tr>
									<td><input type="password" name="text_login_password"
										required></td>
								</tr>
								<tr>
									<td colspan="2" align="right">
										<button type="submit" id="butt_login" name="butt_login"></button>
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td></td>
								</tr>
							</table>
						</td>
				</table>
				<div id="error_message">
					<p>
						<c:if test="${status == 'USER_NOT_EXIST' || status == 'CREDENTIAL_MISMATCH'}">
							* Combination of username & password cannot be found.
						</c:if>
						<c:if test="${status == 'SQL_EXCEPTION'}">
							* Exception in database occured. Please contact Admin.
						</c:if>
					</p>
				</div>
			</fieldset>
		</form>
	</div>
</body>

<footer>
	<div>
	* By logging in, you indicate your agreement to provide your daily working details promptly & accurately.
	</div>
	
	<br>
	
	<jsp:include page="/JSPs/Footer.jsp"></jsp:include>
</footer>
</html>