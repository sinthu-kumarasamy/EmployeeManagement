<%-- 
    Document   : add_employee
    Created on : Dec 5, 2020, 12:58:26 PM
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
        <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        </script>       
<script>
$(document).ready(function(){
    $("#employeeRole").change(function(){
       var textselected =  document.getElementById("employeeRole").value ;
       if(textselected === "manager")
        $('#reporting_manager').hide();
       else
        $('#reporting_manager').show(); 
    });
  });
</script>
    </head>
    
 
    <body>
      <c:set var="managerList" value="${managerList}" />
	<div align="center">
		<h2>Add New Employee</h2>
		<form:form modelAttribute="user" method="post">
			<table class="login">
				<tr>
					<td>First Name:</td>
					<td><form:input path="first_name" size="30" />
						<font color="red"><form:errors path="first_name" /></font></td>
				</tr>
				<tr>
					<td>Last Name:</td>
					<td><form:input path="last_name" size="30" />
						<font color="red"><form:errors path="last_name" /></font></td>
				</tr>
                                <tr>
					<td>Email ID:</td>
					<td><form:input path="email" size="30"
							type="email" /> <font color="red"><form:errors
								path="email" /></font></td>
				</tr>
                                 <tr>
					<td>Address:</td>
					<td><form:input path="address" size="30"
							 /> <font color="red"><form:errors
								path="address" /></font></td>
				</tr>
				  <tr>
					<td>Contact Number:</td>
					<td><form:input path="contact" size="30"
							type="number" /> <font color="red"><form:errors
								path="contact" /></font></td>
				</tr>
                                <tr>
					<td>Role :</td>
					<td><form:select id="employeeRole" path="role">
                                                <form:option value="associate">Associate</form:option>
                                                <form:option value="manager">Manager</form:option>
                                                
					</form:select></td>
				</tr>
                                 <tr>
					<td>Title:</td>
					<td><form:input path="title" size="30"
							 /> <font color="red"><form:errors
								path="title" /></font></td>
				</tr>
                                
                                <tr id="reporting_manager">
					<td>Reporting Manager :</td>
					<td><form:select id="manager" path="manager_id">
                                                <c:forEach var="item" items="${managerList}">
						    <option value="${item.user_id}">${item.first_name} ${item.last_name}</option>
						</c:forEach>
					</form:select></td>
				</tr>
                                
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Add Employee" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>
