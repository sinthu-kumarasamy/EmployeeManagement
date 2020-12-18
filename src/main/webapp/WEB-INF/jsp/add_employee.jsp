<%-- 
    Document   : add_employee
    Created on : Dec 5, 2020, 12:58:26 PM
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
    <script>
        $(document).ready(function () {
            $("#employeeRole").change(function () {
                var textselected = document.getElementById("employeeRole").value;
                if (textselected === "manager")
                    $('#reporting_manager').hide();
                else
                    $('#reporting_manager').show();
            });
        });
    </script>
</head>


<body>
    <c:set var="managerList" value="${managerList}" />
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <form:form modelAttribute="user" method="post">
        <p style="text-align: center;font-size: 20px;font-weight: bold">Add New Employee</p>
        <div class="form-content">
            <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <label>First Name:</label><form:input path="first_name" size="30" />
            <font color="red"><form:errors path="first_name" /></font>
            <label>Last Name:</label><form:input path="last_name" size="30" />
            <font color="red"><form:errors path="last_name" /></font>
            <label>Email ID:</label><form:input path="email" size="30"
                        type="email" /> <font color="red"><form:errors
                        path="email" /></font>
            <label>Address:</label><form:input path="address" size="30"
                        /> <font color="red"><form:errors
                        path="address" /></font>
            <label>Contact Number:</label><form:input path="contact" size="30"
                        type="number" /> <font color="red"><form:errors
                        path="contact" /></font>
            <label>Role :</label>
            <form:select id="employeeRole" path="role">
                <form:option value="associate">Associate</form:option>
                <form:option value="manager">Manager</form:option>

            </form:select>
            <label>Title:</label><form:input path="title" size="30"
                        /> <font color="red"><form:errors
                        path="title" /></font>

            <div id="reporting_manager">
                <label>Reporting Manager :</label>
                <form:select id="manager" path="manager_id">
                    <c:forEach var="item" items="${managerList}">
                        <option value="${item.user_id}">${item.first_name} ${item.last_name}
                        </c:forEach>
                    </form:select>
            </div>

            <input class="button" type="submit"
                   value="Add Employee" />
            <span class="psw"><a class="reg-button" href="${contextPath}/admin/list_employee.htm">Back</a></span>
        </div>		
    </form:form>
</body>
</html>
