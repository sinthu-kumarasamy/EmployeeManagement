<%-- 
    Document   : reset_password
    Created on : Dec 17, 2020, 9:08:18 PM
    Author     : Sindhu
--%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
        <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
        
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
         
	<div align="center">
		<h4>Reset Password</h4>
		<form:form  modelAttribute="user" method="post">
			<table class="login">
				<tr>
					<td>Email:</td>
					<td><form:input path="email" size="30" /><font color="red"><form:errors
								path="email" /></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><form:password  path="password" size="30"
						/><font color="red"><form:errors
								path="password" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit" value="Login" /></td>
				</tr>
			</table>
		</form:form>
	</div>
    </body>
</html>
