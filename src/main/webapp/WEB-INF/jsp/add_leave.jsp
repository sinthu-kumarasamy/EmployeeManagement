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
        <style><%@include file="/resources/css/style.css"%></style>
    </head>
    <body>

        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <form:form modelAttribute="leaveInfo" method="post">
            <div class="form-content">
                <p style="text-align: center;font-size: 20px;font-weight: bold">Add Leave</p>
                <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
                <label>Employee Name:</label><select name="user_id">
                    <c:forEach var="item" items="${employeeList}">
                        <option value="${item.user_id}">${item.first_name}${item.last_name}</option>
                    </c:forEach>
                </select>

                <label>No. Of Days:</label>
                <form:input path="no_of_days" type="number" size="30" />
                <font color="red"><form:errors path="no_of_days" /></font>

                <label>Select Year:</label>
                <form:select path="year">
                    <c:forEach begin="0" end="10" var="val">
                        <c:set var="yr" value="${2020+val}"/>
                        <form:option value="${yr}">${yr}</form:option>
                    </c:forEach>
                </form:select>
                <input class="button" type="submit"
                       value="Add Leaves" /></td>
            <span class="psw"><a class="reg-button" href="${contextPath}/admin/list_leaves.htm">Back</a></span>
        </div>		
    </form:form>

</body>
</html>
