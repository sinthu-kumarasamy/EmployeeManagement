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
        <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
        <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>
	<c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<c:set var="leaveList" value="${leaveList}" />
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
                               <li><a href="${pageContext.request.contextPath}/associate/employee_tasks.htm">My Tasks</a></li> 
                               <li><a href="${pageContext.request.contextPath}/associate/employee_leaves.htm">Apply Leave</a></li>
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
           <c:if test="${addedLeave}">
                        <p style="color:green">Assigned leave Successfully</p>
                    </c:if>
               <c:if test="${updatedLeave}">
                        <p style="color:green">Updated leave details Successfully</p>
                    </c:if>
                        <a class="btn btn-primary" href="${contextPath}/associate/apply_leaves.htm">Apply Leave</a><br>
		<table class="login" border="3">
			<tr>
				<th>Employee Name</th>
				<th>From</th>
                                <th>To</th>
                                <th>Reason</th>
                                <th>Status</th>
				<th>Update</th>
			</tr>
                        <c:forEach items="${leaveList}" var="leave">	
                            <tr>
                                        <td>${leave.user.first_name} ${leave.user.last_name}</td>
                                        <td><fmt:formatDate type = "date" value = "${leave.start_date}" /></td>
                                        <td><fmt:formatDate type = "date" value = "${leave.end_date}" /></td>
                                        <td>${leave.reason}</td>
                                        <td>${leave.status}</td>
                                         <td><a  href="editLeaves/${leave.id}">Update</a></td>
                                         <td><a  href="deleteLeave/${leave.id}">Delete</a></td> 
                                </tr>
				
			</c:forEach>

		</table>
	</div>
</body>
</html>
