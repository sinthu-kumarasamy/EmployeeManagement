<%-- 
    Document   : update_tasks
    Created on : Dec 17, 2020, 11:44:36 AM
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
        <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
        <script src="http://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>   
        <script>
            $(document).ready(function () {
                var start_date = new Date("${task.start_date}");
                var end_date = new Date("${task.end_date}");
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
        <c:set var="employeeList" value="${employeeList}" />
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />


        <form:form modelAttribute="task" action="${contextPath}/manager/updateTask" method="post">
            <input type="hidden" value="${task.id}" name="id"/>
            <div class="form-content">
                <p style="text-align: center;font-size: 20px;font-weight: bold">Update Task</p>
                <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
                <label>Task Desc:</label><form:input path="taskDesc" size="30" />
                <font color="red"><form:errors path="taskDesc" /></font>
                <label>Credits:</label><form:input type="number" path="credits" size="30" />
                <font color="red"><form:errors path="credits" /></font>
                <label>Start Date:</label><input id="start_date" type="date" name="start_date" 
                                                 value="${task.start_date}" /> <font color="red"><form:errors
                    path="start_date" /></font>
                <label>End Date:</label><input id="end_date" name="end_date" type="date"
                                               value="${task.end_date}"  /> <font color="red"><form:errors
                    path="end_date" /></font>
                <label>Status :</label><form:select  path="status">
                    <form:option value="pending">Pending</form:option>
                    <form:option value="completed">Completed</form:option>

                </form:select><form:errors
                    path="status" />
                <label>Assign To:</label><select name="user_id">
                    <c:forEach var="item" items="${employeeList}">
                        <option value="${item.user_id}"${item.user_id == task.user.user_id ? 'selected="selected"' : ''}>${item.first_name}${item.last_name}</option>
                    </c:forEach>
                </select><input class="button" type="submit"
                                value="Update Task" /></td>
            <span class="psw"><a class="reg-button" href="${contextPath}/manager/list_tasks.htm">Back</a></span></div>
        </form:form>

</body>
</html>