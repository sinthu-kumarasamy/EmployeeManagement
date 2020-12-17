<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Add User Form</title>
<link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>
         <c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div align="center">
		<a class="btn btn-primary" href="${contextPath}">Home</a>
		<h2>New User? Register below!</h2>
		<form:form modelAttribute="user" method="post">
			<table class="login">
				<tr>
					<td>First Name:</td>
					<td><form:input path="first_name" size="30" />
						<font color="red"><form:errors path="first_name" /></font></td>
				</tr>
				<tr>
					<td>Last Name:</td>
					<td><form:input path="last_name" size="30" />
						<font color="red"><form:errors path="last_name" /></font></td>
				</tr>
                                <tr>
					<td>Email ID:</td>
					<td><form:input path="email" size="30"
							type="email" /> <font color="red"><form:errors
								path="email" /></font></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><form:password path="password" minlength="5" size="30"
						 /> <font color="red"><form:errors
								path="password" /></font></td>
				</tr>
                                 <tr>
					<td>Address:</td>
					<td><form:input path="address" size="30"
							 /> <font color="red"><form:errors
								path="address" /></font></td>
				</tr>
				  <tr>
					<td>Contact Number:</td>
					<td><form:input path="contact" size="30"
							type="number" /> <font color="red"><form:errors
								path="contact" /></font></td>
				</tr>
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Register" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>