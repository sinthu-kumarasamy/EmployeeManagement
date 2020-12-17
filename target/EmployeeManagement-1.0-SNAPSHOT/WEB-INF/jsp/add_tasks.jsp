<%-- 
    Document   : add_tasks
    Created on : Dec 12, 2020, 2:49:32 PM
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

    </head>
    
 
    <body>
      <c:set var="employeeList" value="${employeeList}" />
	<div align="center">
		<h2>Add New Task</h2>
		<form:form modelAttribute="task" method="post">
			<table class="login">
				<tr>
					<td>Task Desc:</td>
					<td><form:input path="taskDesc" size="30" />
						<font color="red"><form:errors path="taskDesc" /></font></td>
				</tr>
				<tr>
					<td>Credits:</td>
					<td><form:input type="number" path="credits" size="30" />
						<font color="red"><form:errors path="credits" /></font></td>
				</tr>
                                <tr>
					<td>Start Date</td>
					<td><input type="date" name="start_date" 
							 /> <font color="red"><form:errors
								path="start_date" /></font></td>
				</tr>
                                 <tr>
					<td>End Date:</td>
					<td><input name="end_date" type="date"
							 /> <font color="red"><form:errors
								path="end_date" /></font></td>
				</tr>
                                <tr>
					<td>Status :</td>
					<td><form:select  path="status">
                                                <form:option value="pending">Pending</form:option>
                                                <form:option value="completed">Completed</form:option>
                                                
					</form:select><form:errors
								path="status" /></td>
				</tr>
                         
                                <tr>
					<td>Assign To:</td>
					<td><select name="user_id">
                                               <c:forEach var="item" items="${employeeList}">
						   <option value="${item.user_id}">${item.first_name}${item.last_name}</option>
						</c:forEach>
					</select></td>
				</tr>
                                
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Add Task" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>
