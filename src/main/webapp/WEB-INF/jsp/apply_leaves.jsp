<%-- 
    Document   : apply_leaves
    Created on : Dec 12, 2020, 7:51:29 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style><%@include file="/resources/css/style.css"%></style>
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </script>       

</head>


<body>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    <form:form modelAttribute="leave" method="post">
        <div class="form-content">
            <p style="text-align: center;font-size: 20px;font-weight: bold">Apply Leave</p>
            <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <label>Start Date</label>
            <form:input type="date" path="start_date" 
                   /> <font color="red"><form:errors
                path="start_date" /></font>
            <label>End Date:</label>
            <form:input path="end_date" type="date"
                   /> <font color="red"><form:errors
                path="end_date" /></font>
            <label>Reason:</label>
            <form:input path="reason" size="30" />
            <font color="red"><form:errors path="reason" /></font>

            <input class="button" type="submit"/>
                   <span class="psw"><a class="reg-button" href="${contextPath}/associate/employee_leaves.htm">Back</a></span>
        </div>		
    </form:form>

</body>
</html>

