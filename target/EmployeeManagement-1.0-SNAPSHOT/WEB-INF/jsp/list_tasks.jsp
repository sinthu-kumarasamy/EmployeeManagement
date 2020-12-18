<%-- 
    Document   : list_tasks
    Created on : Dec 12, 2020, 2:56:22 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
        <c:set var="tasklist" value="${taskList}" />
        <nav class="navbar navbar-inverse" style="height:70px">
            <p style="text-align: center;font-size: 40px;color:white;font-weight: bold">Employee Management Portal</p>
            <ul class="nav navbar-nav" style="float:right">
                <li><a href="${pageContext.request.contextPath}/manager/list_tasks.htm">View/Add Tasks</a></li>
                <li><a href="${pageContext.request.contextPath}/manager/approve_leaves.htm">Leave Approval</a></li>
                <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
        <div align="center" style="margin-top: 250px">
            <c:if test="${addedTask}">
                <p style="color:green">Added New Task Successfully</p>
            </c:if>
            <c:if test="${updatedTask}">
                <p style="color:green">Updated Task Successfully</p>
            </c:if>
            <a class="reg-button" href="${contextPath}/manager/add_tasks.htm">Add New Task</a><br>
            <table class="table table-striped" id="emp-table">
                <thead>
                <th>Task Description</th>
                <th>Credits</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Assigned To</th>
                <th>Status</th>
                <th>Update/Delete Task</th>
                </thead>
                <c:forEach items="${tasklist}" var="task">
                    <tr>
                        <td>${task.taskDesc}</td>
                        <td>${task.credits}</td>
                        <td><fmt:formatDate type = "date" value = "${task.start_date}" /></td>
                        <td><fmt:formatDate type = "date" value = "${task.end_date}" /></td>
                        <td>${task.user.first_name}${task.user.last_name}</td>
                        <td>${task.status}</td>
                        <td><a  href="updateTask/${task.id}">Update</a>
                            <a  href="deleteTask/${task.id}">Delete</a></td>
                    </tr>


                </c:forEach>
            </table>
        </div>
    </body>
</html>
