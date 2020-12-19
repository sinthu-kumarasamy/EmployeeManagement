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
        <style><%@include file="/resources/css/style.css"%></style>
        <title>JSP Page</title>
    </head>
    <body>
        <c:set var="leaveInfo" value="${leaveInfo}"/>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <form:form modelAttribute="leaveInfo" action="${contextPath}/admin/updateLeaves" method="post">
            <input type="hidden" value="${leaveInfo.id}" name="id"/>
            <div class="form-content">
                <p style="text-align: center;font-size: 20px;font-weight: bold">Update Leave</p>
                <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
                <label>Employee Name:</label>
                <form:select path="user.user_id" disabled="disabled">
                    <c:forEach var="item" items="${employeeList}">
                        <option value="${item.user_id}"${item.user_id == leaveInfo.user.user_id ? 'selected="selected"' : ''}>${item.first_name}${item.last_name}</option>
                    </c:forEach>
                </form:select>
                <label>No. Of Days:</label><form:input path="no_of_days" type="number" size="30"/>
                <font color="red"><form:errors path="no_of_days" /></font>
                <label>Select Year:</label><form:select path="year">
                    <c:forEach begin="0" end="10" var="val">
                        <c:set var="yr" value="${2020+val}"/>
                        <option value="${yr}"${yr == leaveInfo.year ? 'selected="selected"' : ''}>${yr}</option>
                    </c:forEach>
                </form:select>
                <input class="button" type="submit"
                       value="Update Leave" />
                <span class="psw"><a class="reg-button" href="${contextPath}/admin/list_leaves.htm">Back</a></span>
            </div>	
        </form:form>

    </body>
</html>

