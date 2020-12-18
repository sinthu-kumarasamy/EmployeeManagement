<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add User Form</title>
        <style><%@include file="/resources/css/style.css"%></style>
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <!-- jQuery library -->
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />

        <form:form modelAttribute="user" method="post">
            <div class="form-content">
             <p style="text-align: center;font-size: 20px;font-weight: bold">New User? Register below!</p>
             <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
                <label>First Name:</label>
                <form:input path="first_name" size="30" />
                <font color="red"><form:errors path="first_name" /></font>
                <label>Last Name:</label>
                <form:input path="last_name" size="30" />
                <font color="red"><form:errors path="last_name"/></font>
                <label>Email ID:</label>
                <form:input path="email" size="30" type="email" /> <font color="red"><form:errors
                    path="email" /></font>
                <label>Password:</label>
                <form:password path="password" minlength="5" size="30"
                               /> <font color="red"><form:errors
                               path="password" /></font>
                <label>Address:</label>
                <form:input path="address" size="30"
                            /> <font color="red"><form:errors
                            path="address" /></font>
                <label>Contact Number:</label>
                <form:input path="contact" size="30"
                            type="number" /> <font color="red"><form:errors
                            path="contact" /></font>
                <label>Title:</label>
                <form:input path="title" size="30"
                            /> <font color="red"><form:errors
                            path="title" /></font>
                <input class="button" type="submit" value="Register" />
                 <span class="psw"><a class="reg-button" href="${contextPath}">Back</a></span>
            </div>		

        </form:form>

    </body>
</html>