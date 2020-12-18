<%-- 
    Document   : employee_leaves
    Created on : Dec 12, 2020, 8:17:59 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
            <ul class="nav navbar-nav" style="float:right">
                 <li><a href="${pageContext.request.contextPath}/associate/employee_tasks.htm">My Tasks</a></li> 
                 <li><a href="${pageContext.request.contextPath}/associate/employee_leaves.htm">Apply Leave</a></li>
                 <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
        <div align="center" style="margin-top: 250px">
            <c:if test="${addedLeave}">
                <p style="color:green">Applied for leave Successfully</p>
            </c:if>
            <c:if test="${updatedLeave}">
                <p style="color:green">Updated leave details Successfully</p>
            </c:if>
            <c:if test="${applyLeave}">
                <p style="color:green">Leave not allocated for the selected year.Please contact HR for more details</p>
            </c:if>
            <a class="reg-button" href="${contextPath}/associate/apply_leaves.htm">Apply Leave</a><br>
            <table class="table table-striped" id="emp-table">
                <thead>
                <th>Employee Name</th>
                <th>From</th>
                <th>To</th>
                <th>Reason</th>
                <th>Status</th>
                <th>Update/Delete</th>
                </thead>
                <c:forEach items="${leaveList}" var="leave">	
                    <tr>
                        <td>${leave.user.first_name} ${leave.user.last_name}</td>
                        <td><fmt:formatDate type = "date" value = "${leave.start_date}" /></td>
                        <td><fmt:formatDate type = "date" value = "${leave.end_date}" /></td>
                        <td>${leave.reason}</td>
                        <td>${leave.status}</td>
                        <c:if test="${leave.status ne'Approve'}">
                            <td><a  href="editLeaves/${leave.id}">Update</a>
                                <a  href="deleteLeave/${leave.id}">Delete</a></td> 
                            </c:if>
                    </tr>

                </c:forEach>

            </table>
        </div>
    </body>
</html>
