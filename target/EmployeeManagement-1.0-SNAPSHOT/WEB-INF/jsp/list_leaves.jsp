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
        <style><%@include file="/resources/css/style.css"%></style>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:set var="leaveList" value="${leaveList}" />
       <nav class="navbar navbar-inverse" style="height:70px">
            <p style="text-align: center;font-size: 40px;color:white;font-weight: bold">Employee Management Portal</p>
            <p style="text-align: right;font-size: 20px;font-weight: bold">Hello ${user.first_name}${user.last_name}</p>
            <ul class="nav navbar-nav" style="float:right">
                <li><a href="${pageContext.request.contextPath}/admin/list_employee.htm">View/Add Employee</a></li> 
                <li><a href="${pageContext.request.contextPath}/admin/list_leaves.htm">View/Add Leave</a></li>
                <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
        <div align="center" style="margin-top: 250px">
            <c:if test="${addedLeave}">
                <p style="color:green">Assigned leave Successfully</p>
            </c:if>
            <c:if test="${updatedLeave}">
                <p style="color:green">Updated leave details Successfully</p>
            </c:if>
            <a class="reg-button" href="${contextPath}/admin/add_leaves.htm">Add Leave</a><br>
            <table class="table table-striped" id="emp-table">
                <thead>
                <th>Employee Name</th>
                <th>Leaves Allocated</th>
                <th>Year</th>
                <th>Update/Delete</th>
                </thead>
                <c:forEach items="${leaveList}" var="leave">

                    <tr>
                        <td>${leave.user.first_name} ${leave.user.last_name}</td>
                        <td>${leave.no_of_days}</td>
                        <td>${leave.year}</td>
                        <td><a  href="updateLeaves/${leave.id}">Update</a>
                            <a  href="deleteLeave/${leave.id}">Delete</a></td>
                    </tr>

                </c:forEach>

            </table>
        </div>
    </body>
</html>
