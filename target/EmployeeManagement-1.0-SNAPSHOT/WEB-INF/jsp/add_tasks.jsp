<%-- 
    Document   : add_tasks
    Created on : Dec 12, 2020, 2:49:32 PM
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
    <c:set var="employeeList" value="${employeeList}" />
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <form:form modelAttribute="task" method="post">
        <div class="form-content">
            <p style="text-align: center;font-size: 20px;font-weight: bold">Add New Task</p>
            <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <label>Task Desc:</label>
            <form:input path="taskDesc" size="30" />
            <font color="red"><form:errors path="taskDesc" /></font>
            <label>Credits:</label>
            <form:input type="number" path="credits" size="30" />
            <font color="red"><form:errors path="credits" /></font>
            <label>Start Date:</label>
            <input type="date" name="start_date" 
                   /> <font color="red"><form:errors
                path="start_date" /></font>
            <label>End Date:</label>
            <input name="end_date" type="date"
                   /> <font color="red"><form:errors
                path="end_date" /></font>
            <label>Status :</label>
            <form:select  path="status">
                <form:option value="pending">Pending</form:option>
                <form:option value="completed">Completed</form:option>

            </form:select><form:errors
                path="status" />
            <label>Assign To:</label>
            <select name="user_id">
                <c:forEach var="item" items="${employeeList}">
                    <option value="${item.user_id}">${item.first_name}${item.last_name}</option>
                </c:forEach>
            </select>
            <input class="button" type="submit"
                   value="Add Task" />
            <span class="psw"><a class="reg-button" href="${contextPath}/manager/list_tasks.htm">Back</a></span>
        </div>
    </form:form>

</body>
</html>
