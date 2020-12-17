<%-- 
    Document   : employe_page
    Created on : Dec 12, 2020, 7:28:04 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        <title>Add Employee</title>
    </head>
    <body>
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
	  
	  
<!--	   <img class="img-responsive" src="resources/images/office.jpg" alt="office" width="1900" height="300">-->



<!--    <footer class="footer">
      <div class="container">
        <p class="text-muted">For more details follow us @Job Portal.</p>
      </div>
    </footer>-->

</div>
    </body>
</html>
