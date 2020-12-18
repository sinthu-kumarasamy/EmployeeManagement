<%-- 
    Document   : admin_page
    Created on : Dec 4, 2020, 2:15:11 PM
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
         <style><%@include file="/resources/css/style.css"%></style>
    </head>
    <body>
  
                                
     <nav class="navbar navbar-inverse" style="height:70px">
            <p style="text-align: center;font-size: 40px;color:white;font-weight: bold">Employee Management Portal</p>
            <ul class="nav navbar-nav" style="float:right">
                <li><a href="${pageContext.request.contextPath}/admin/list_employee.htm">View/Add Employee</a></li> 
                <li><a href="${pageContext.request.contextPath}/admin/list_leaves.htm">View/Add Leave</a></li>
                <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
                                  
    </body>
</html>
