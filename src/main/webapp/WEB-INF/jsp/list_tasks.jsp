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
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
        <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<c:set var="tasklist" value="${taskList}" />
        <div class= "navbar">
           <nav class="navbar navbar-default ">
            <div class="container-fluid bg-sucess">
<!--            <div class="navbar-header ">
            
                <a class="navbar-brand" href="${pageContext.request.contextPath}/diverthome.htm">Job Portal</a>
                </div>-->
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav bg-info">
                         <li class="active "><a href="#">Dashboard</a></li>
            
                  </ul>
                    <ul class="nav navbar-nav navbar-right">
                              <li><a href="${pageContext.request.contextPath}/manager/list_tasks.htm">View/Add Tasks</a></li> 
                               <li><a href="${pageContext.request.contextPath}/manager/approve_leaves.htm">Leave Approval</a></li>
                               <li><a href="${pageContext.request.contextPath}">Logout</a></li>
                               <!--   <li><a href="${pageContext.request.contextPath}/jobseekerregister.htm">New Employees</a></li>
                                <li><a href="${pageContext.request.contextPath}/employerLogin.htm">Sign In</a></li> -->
                                <li class="logindd dropdown">
       
             </li>
                    </ul>
              </div>
            </div>
        </nav> 
        </div>
	<div align="center">
           <c:if test="${addedTask}">
                        <p style="color:green">Added New Task Successfully</p>
                    </c:if>
                      <c:if test="${updatedTask}">
                        <p style="color:green">Updated Task Successfully</p>
                    </c:if>
                        <a class="btn btn-primary" href="${contextPath}/manager/add_tasks.htm">Add New Task</a><br>
		<table class="login" border="3">
			<tr>
				<th>Task Description</th>
				<th>Credits</th>
				<th>Start Date</th>
				<th>End Date</th>
				<th>Assigned To</th>
				<th>Status</th>
				<th>Update Task</th>
			</tr>
			<c:forEach items="${tasklist}" var="task">
                                <tr>
                                        <td>${task.taskDesc}</td>
                                        <td>${task.credits}</td>
                                        <td><fmt:formatDate type = "date" value = "${task.start_date}" /></td>
                                        <td><fmt:formatDate type = "date" value = "${task.end_date}" /></td>
                                        <td>${task.user.first_name}${task.user.last_name}</td>
                                        <td>${task.status}</td>
                                         <td><a  href="updateTask/${task.id}">Update</a></td>
                                        <td><a  href="deleteTask/${task.id}">Delete</a></td>
                                </tr>
			  

			</c:forEach>
		</table>
	</div>
</body>
</html>
