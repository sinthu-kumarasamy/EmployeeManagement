<%-- 
    Document   : apply_leaves
    Created on : Dec 12, 2020, 7:51:29 PM
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
	<div align="center">
		<h2>Apply Leave</h2>
		<form:form modelAttribute="leave" method="post">
			<table class="login">
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
					<td>Reason:</td>
					<td><form:input path="reason" size="30" />
						<font color="red"><form:errors path="reason" /></font></td>
				</tr>
                 
				<tr>
					<td><input class="btn btn-primary" type="submit"
						value="Apply" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>

