<%-- 
    Document   : update_appliedLeaves
    Created on : Dec 17, 2020, 11:44:22 AM
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
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </script>
    <script>
        $(document).ready(function () {
            var start_date = new Date("${leave.start_date}");
            var end_date = new Date("${leave.end_date}");
            var start_month = start_date.getMonth() + 1;
            var startdate = start_date.getDate();
            if (start_month < 10) {
                start_month = '0' + start_month;
            }
            if (startdate < 10) {
                startdate = '0' + startdate;
            }
            var startDate = start_date.getFullYear() + '-' + start_month + '-' + startdate;
            $("#start_date").val(startDate);
            var end_month = end_date.getMonth() + 1;
            var enddate = end_date.getDate();
            if (end_month < 10) {
                end_month = '0' + end_month;
            }
            if (enddate < 10) {
                enddate = '0' + enddate;
            }
            var endDate = end_date.getFullYear() + '-' + end_month + '-' + enddate;
            $("#end_date").val(endDate);
        });
    </script>

</head>


<body>
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />

    
    <form:form modelAttribute="leave" action="${contextPath}/associate/editLeaves.htm" method="post">
        <div class="form-content">
            <p style="text-align: center;font-size: 20px;font-weight: bold">Edit Leave</p>
            <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <input type="hidden" value="${leave.id}" name="id"/>
            <label>Start Date</label>
            <input id="start_date" type="date" name="start_date" 
                   value="${leave.start_date}" /> <font color="red"><form:errors
                path="start_date" /></font>
            <label>End Date:</label>
            <input id="end_date" name="end_date" type="date"
                   value="${leave.end_date}"  /> <font color="red"><form:errors
                path="end_date" /></font>
            <label>Reason:</label>
            <form:input path="reason" size="30" />
            <font color="red"><form:errors path="reason" /></font><input class="button" type="submit"
                                                                         value="Apply" />
            <span class="psw"><a class="reg-button" href="${contextPath}/associate/employee_leaves.htm">Back</a></span>
        </div>
    </form:form>
</div>
</body>
</html>

