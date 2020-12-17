<%-- 
    Document   : add_leave
    Created on : Dec 5, 2020, 7:34:27 PM
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
    </head>
     <body>
      
	<div align="center">
		<h2>Add Leave</h2>
		<form:form modelAttribute="leaveInfo" method="post">
			<table class="login">
				<tr>
					<td>Employee Name:</td>
					<td><select name="user_id">
                                               <c:forEach var="item" items="${employeeList}">
						   <option value="${item.user_id}">${item.first_name}${item.last_name}</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>No. Of Days:</td>
					<td><form:input path="no_of_days" type="number" size="30" />
						<font color="red"><form:errors path="no_of_days" /></font></td>
				</tr>
                                <tr>
					<td>Select Year:</td>
					<td><form:select path="year">
                                            <c:forEach begin="0" end="10" var="val">
                                                <c:set var="yr" value="${2020+val}"/>
                                                <form:option value="${yr}">${yr}</form:option>
                                            </c:forEach>
                                        </form:select></td>
				</tr>        
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Add Leaves" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>
