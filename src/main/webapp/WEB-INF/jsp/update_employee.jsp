<%-- 
    Document   : update_employee
    Created on : Dec 17, 2020, 11:37:03 AM
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
            var textselected = document.getElementById("employeeRole").value;
            if (textselected === "manager")
                $('#reporting_manager').hide();
            else
                $('#reporting_manager').show();

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
    <c:set var="managerList" value="${managerList}"/>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    <c:set var="employee" value="${user}"/>
    <form:form modelAttribute="user" action="${contextPath}/admin/updateUser" method="post">
        <p style="text-align: center;font-size: 20px;font-weight: bold">Update Employee</p>
        <div class="form-content">
            <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <input type="hidden" value="${employee.user_id}" name="id"/>
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
                <option value="associate" ${employee.role == "associate" ? 'selected="selected"' : ''}>Associate</option>
                <option value="manager" ${employee.role == "manager" ? 'selected="selected"' : ''}>Manager</option>

            </form:select>
            <label>Title:</label><form:input path="title" size="30"
                        /> <font color="red"><form:errors
                        path="title" /></font>

            <div id="reporting_manager">
                <label>Reporting Manager :</label>
                <form:select id="manager" path="manager_id">
                    <c:forEach var="item" items="${managerList}">
                        <option value="${item.user_id}"${item.user_id == employee.manager_id ? 'selected="selected"' : ''}>${item.first_name} ${item.last_name}</option>
                    </c:forEach>
                </form:select>
            </div>

            <input class="button" type="submit"
                   value="Update Employee" />
            <span class="psw"><a class="reg-button" href="${contextPath}/admin/list_employee.htm">Back</a></span>
        </div>
    </form:form>

</body>
</html>

