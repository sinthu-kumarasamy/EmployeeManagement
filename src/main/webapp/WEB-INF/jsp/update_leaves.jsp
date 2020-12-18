<%-- 
    Document   : update_leaves
    Created on : Dec 17, 2020, 11:43:36 AM
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
      <c:set var="leaveInfo" value="${leaveInfo}"/>
       <c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div align="center">
		<h2>Update Leave</h2>
		<form:form modelAttribute="leaveInfo" action="${contextPath}/admin/updateLeaves" method="post">
                    <input type="hidden" value="${leaveInfo.id}" name="id"/>
			<table class="login">
				<tr>
					<td>Employee Name:</td>
                                        <td><select name="user_id" disabled="disabled">
                                               <c:forEach var="item" items="${employeeList}">
						   <option value="${item.user_id}"${item.user_id == leaveInfo.user.user_id ? 'selected="selected"' : ''}>${item.first_name}${item.last_name}</option>
						</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>No. Of Days:</td>
					<td><form:input path="no_of_days" type="number" size="30"/>
						<font color="red"><form:errors path="no_of_days" /></font></td>
				</tr>
                                <tr>
					<td>Select Year:</td>
					<td><form:select path="year">
                                            <c:forEach begin="0" end="10" var="val">
                                                <c:set var="yr" value="${2020+val}"/>
                                                <option value="${yr}"${yr == leaveInfo.year ? 'selected="selected"' : ''}>${yr}</option>
                                            </c:forEach>
                                        </form:select></td>
				</tr>        
				<tr>
					<td></td>
					<td><input class="btn btn-primary" type="submit"
						value="Update Leave" /></td>
				</tr>
			</table>
		</form:form>
	</div>
</body>
</html>

