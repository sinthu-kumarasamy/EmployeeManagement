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
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <style><%@include file="/resources/css/style.css"%></style>
    </head>

    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:if test="${resetSuccess}">
            <p style="color:green">Password has been changed successfully.Please login with your credentials below!</p>
        </c:if>
        <c:if test="${addedUser}">
            <p style="color:green">Registration Success!</p>
        </c:if>
        <form:form action="login.htm" modelAttribute="user" method="post">

            <div class="form-content">
                <p style="text-align: center;font-size: 20px;font-weight: bold">Login</p>
                 <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
                </c:if>
                <label for="uname"><b>Username</b></label>
                <form:input path="email" size="30" /><font color="red"><form:errors path="email" /></font>

                <label for="psw"><b>Password</b></label>
                <form:password  path="password" size="30"/><font color="red"><form:errors path="password" />

                <input class="button" value="Login" type="submit"/>
                <span class="psw" style="float:left"><a class="reg-button" href="${contextPath}/register.htm">Register</a></span>
                <span class="psw"><a class="reg-button" href="${contextPath}/reset_password.htm">Reset Password</a></span>
            </div>
        </form:form>
    </body>
</html>


