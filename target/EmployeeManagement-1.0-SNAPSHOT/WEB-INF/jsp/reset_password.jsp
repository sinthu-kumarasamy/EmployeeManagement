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
        <style><%@include file="/resources/css/style.css"%></style>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>

</head>
<body>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <form:form  modelAttribute="user" method="post">
        <div class="form-content">
            <p style="text-align: center;font-size: 20px;font-weight: bold">Reset Password</p>
             <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <label for="uname"><b>Username</b></label>
            <form:input path="email" size="30" /><font color="red"><form:errors path="email" /></font>

            <label for="psw"><b>Password</b></label>
            <form:password  path="password" size="30"/><font color="red"><form:errors path="password" />

            <input class="button" type="submit"/>
        </div>
    </form:form>

</body>
</html>
