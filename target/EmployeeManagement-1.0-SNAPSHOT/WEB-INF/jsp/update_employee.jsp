<%-- 
    Document   : update_employee
    Created on : Dec 17, 2020, 11:37:03 AM
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
    var textselected =  document.getElementById("employeeRole").value;
    if(textselected === "manager")
        $('#reporting_manager').hide();
       else
        $('#reporting_manager').show(); 
    
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
      <c:set var="managerList" value="${managerList}"/>
       <c:set var="employee" value="${user}"/>
	<div align="center">
		<h2>Update Employee</h2>
		<form:form modelAttribute="user" method="post">
                      <input type="hidden" value="${employee.user_id}" name="id"/>
			<table class="login">
				<tr>
					<td>First Name:</td>
					<td><form:input path="first_name" size="30" value="${employee.first_name}"/>
						<font color="red"><form:errors path="first_name" /></font></td>
				</tr>
				<tr>
					<td>Last Name:</td>
					<td><form:input path="last_name" size="30" value="${employee.last_name}"/>
						<font color="red"><form:errors path="last_name" /></font></td>
				</tr>
                                <tr>
					<td>Email ID:</td>
					<td><form:input path="email" size="30"
							type="email" value="${employee.email}"/> <font color="red"><form:errors
								path="email" /></font></td>
				</tr>
                                 <tr>
					<td>Address:</td>
					<td><form:input path="address" size="30"
							 value="${employee.address}"/> <font color="red"><form:errors
								path="address" /></font></td>
				</tr>
				  <tr>
					<td>Contact Number:</td>
					<td><form:input path="contact" size="30"
							type="number" value="${employee.contact}"/> <font color="red"><form:errors
								path="contact" /></font></td>
				</tr>
                                <tr>
					<td>Role :</td>
					<td><form:select id="employeeRole" path="role">
                                                <option value="associate" ${employee.role == "associate" ? 'selected="selected"' : ''}>Associate</option>
                                                <option value="manager" ${employee.role == "manager" ? 'selected="selected"' : ''}>Manager</option>
                                                
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
                                                    <option value="${item.user_id}"${item.user_id == employee.manager_id ? 'selected="selected"' : ''}>${item.first_name} ${item.last_name}</option>
                                                </c:forEach>
                                        </form:select></td>
                                </tr>
                               
                                
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Update Employee" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>

