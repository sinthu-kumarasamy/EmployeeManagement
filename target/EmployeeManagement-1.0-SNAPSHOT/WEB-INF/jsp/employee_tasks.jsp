<%-- 
    Document   : employee_tasks
    Created on : Dec 12, 2020, 7:50:30 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.2/css/bootstrap.min.css" 
              integrity="sha384-y3tfxAZXuh4HwSYylfB+J125MxIs6mR5FOHamPBG064zB+AFeWH94NdvaCBm8qnd" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:set var="map" value="${map}" />
        <div class="container">
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
<!--                                  <li><a href="${pageContext.request.contextPath}/employerregister.htm">New Employers</a></li>
                                <li><a href="${pageContext.request.contextPath}/jobseekerregister.htm">New Employees</a></li>
                                <li><a href="${pageContext.request.contextPath}/employerLogin.htm">Sign In</a></li> -->
                                <li class="logindd dropdown">
       
             </li>
                    </ul>
              </div>
            </div>
        </nav>
        <ul class="nav nav-tabs">
          <li class="active"><a data-toggle="tab" href="#pending">Pending Tasks</a></li>
          <li><a data-toggle="tab" href="#completed">Completed Tasks</a></li>
          <li><a data-toggle="tab" href="#overdue">Overdue Tasks</a></li>
        </ul>

        <div class="tab-content">
          <div id="pending" class="tab-pane fade in active">
              <h3>View your Upcoming Tasks</h3>
               <c:if test = "${map['pending'].size()==0}">
                  <c:out value = "No data to show"/><p>
            </c:if>
            <c:forEach  items="${map['pending']}" var="task">
                <form action="${contextPath}/associate/updateTask.htm" method="post">
                    <input type="hidden" value="${task.id}" name="id"/>
                    <div class="card text-center" style="width: 18rem;display:inline-block">
                        <div class="card-header">
                          ${task.taskDesc}
                        </div>
                        <div class="card-body">
                          <h5 class="card-title">Credits : ${task.credits}</h5>
                          <p class="card-text">Start Date : <fmt:formatDate type = "date" value = "${task.start_date}" /></p>
                          <p class="card-text">End Date : <fmt:formatDate type = "date" value = "${task.end_date}" /></p>
                          <input type="submit" class="btn btn-primary" value="Mark As Done"/>
                        </div>
                        <div class="card-footer text-muted">
                            <fmt:formatDate var="start_date" value="${task.start_date}" pattern="D" />
                            <fmt:formatDate var="end_date" value="${task.end_date}" pattern="D" />
                            <fmt:formatDate var="start_year" value="${task.start_date}" pattern="yyyy" />
                            <fmt:formatDate var="end_year" value="${task.end_date}" pattern="yyyy" />
                            <c:if test = "${end_year > start_year}">
                                <c:set var="diff" value = "${(end_year-start_year)*366}"/><p>
                            </c:if>
                            <c:out value="${(diff+end_date)-start_date} days to go"></c:out>
                        </div>
                    </div>
                </form>
            </c:forEach>
          </div>
          <div id="completed" class="tab-pane fade">
            <h3>View Completed tasks</h3>
            <c:if test = "${map['completed'].size()==0}">
                  <c:out value = "No data to show"/><p>
            </c:if>
             <c:forEach  items="${map['completed']}" var="task">
                <div class="card text-center" style="width: 18rem;display:inline-block">
                    <div class="card-header">
                      ${task.taskDesc}
                    </div>
                    <div class="card-body">
                      <h5 class="card-title">Credits : ${task.credits}</h5>
                      <p class="card-text">Start Date : <fmt:formatDate type = "date" value = "${task.start_date}" /></p>
                      <p class="card-text">End Date : <fmt:formatDate type = "date" value = "${task.end_date}" /></p>
                    </div>
                    <div class="card-footer text-muted">
                        ${task.status}
                    </div>
                </div>
            </c:forEach>
          </div>
          <div id="overdue" class="tab-pane fade">
           <h3>View Overdue tasks</h3>
            <c:if test = "${map['overdue'].size()==0}">
                  <c:out value = "No data to show"/><p>
            </c:if>
             <c:forEach  items="${map['overdue']}" var="task">
                 <div class="card text-center" style="width: 18rem;display:inline-block">
             <form action="${contextPath}/associate/updateTask.htm" method="post">
                 <input type="hidden" value="${task.id}" name="id"/>
                
                    <div class="card-header">
                      ${task.taskDesc}
                    </div>
                    <div class="card-body">
                      <h5 class="card-title">Credits : ${task.credits}</h5>
                      <p class="card-text">Start Date : <fmt:formatDate type = "date" value = "${task.start_date}" /></p>
                      <p class="card-text">End Date : <fmt:formatDate type = "date" value = "${task.end_date}" /></p>
                      <input type="submit" class="btn btn-primary" value="Mark As Done"/>
                    </div>
                    <div class="card-footer text-muted">
                        <p style="color:red">${task.status}</p>
                    </div>
               
             </form>
               </div>
            </c:forEach>
          </div>
          </div>
        </div>
      </div>
    </body>
</html>
