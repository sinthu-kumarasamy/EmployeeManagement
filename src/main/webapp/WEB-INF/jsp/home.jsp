<%-- 
    Document   : index
    Created on : Oct 14, 2020, 5:39:26 PM
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
         <c:if test="${resetSuccess}">
                        <p style="color:green">Password has been changed successfully.Please login with your credentials below!</p>
                    </c:if>
	<div align="center">
		<a class="btn btn-primary" href="${contextPath}">Home</a> <a
			class="btn btn-primary" href="${contextPath}/register.htm">Register</a>
		<br />
		<h4>Please enter your details below to login!</h4>
		<form:form action="login.htm" modelAttribute="user" method="post">
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
                 <a  href="${contextPath}/reset_password.htm">Click here to Reset Password</a> 
		<br />
	</div>
    </body>
</html>
