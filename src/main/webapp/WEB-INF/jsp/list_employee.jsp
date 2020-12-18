<%-- 
    Document   : list_employee
    Created on : Dec 5, 2020, 4:14:43 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
        <style><%@include file="/resources/css/style.css"%></style>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:set var="employeelist" value="${employeeList}" />
         <nav class="navbar navbar-inverse" style="height:70px">
            <p style="text-align: center;font-size: 40px;color:white;font-weight: bold">Employee Management Portal</p>
            <ul class="nav navbar-nav" style="float:right">
                <li><a href="${pageContext.request.contextPath}/admin/list_employee.htm">View/Add Employee</a></li> 
                <li><a href="${pageContext.request.contextPath}/admin/list_leaves.htm">View/Add Leave</a></li>
                <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
        <div align="center" style="margin-top: 250px">
            <c:if test="${addedEmployee}">
                <p style="color:green">Added Employee Successfully</p>
            </c:if>
            <c:if test="${updatedEmployee}">
                <p style="color:green">Updated Employee Successfully</p>
            </c:if>
            <a class="reg-button" href="${contextPath}/admin/add_employee.htm">Add New Employee</a><br>
            <table class="table table-striped" id="emp-table">
                <thead>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Email</th>
                <th>Title</th>
                <th>Role</th>
                <th>Reporting Manager</th>
                <th>Update/Delete Employee</th>
                </thead>
                <c:forEach items="${employeelist}" var="employee">
                    <tr>
                        <td>${employee.first_name}</td>
                        <td>${employee.last_name}</td>
                        <td>${employee.email}</td>
                        <td>${employee.title}</td>
                        <td>${employee.role}</td>
                        <td>${employee.manager}</td>
                        <td><a style="margin:5px" href="updateUser/${employee.user_id}">Update</a>
                            <a style="margin:5px" href="deleteUser/${employee.user_id}">Delete</a></td>
                    </tr>


                </c:forEach>
            </table>
        </div>
    </body>
</html>
