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
        <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        </script>
        <script>
          $(document).ready(function(){
            var start_date = new Date("${leave.start_date}");
            var end_date = new Date("${leave.end_date}");
            var start_month = start_date.getMonth() + 1;
            var startdate = start_date.getDate();
            if(start_month<10){
                start_month = '0'+start_month;
            }
            if(startdate<10){
                startdate = '0'+startdate;
            }
            var startDate = start_date.getFullYear()+ '-' + start_month+'-'+ startdate;
            $("#start_date").val(startDate);
            var end_month = end_date.getMonth() + 1;
            var enddate = end_date.getDate();
            if(end_month<10){
                end_month = '0'+end_month;
            }
            if(enddate<10){
                enddate = '0'+enddate;
            }
            var endDate = end_date.getFullYear()+ '-' + end_month+'-'+ enddate;
            $("#end_date").val(endDate);
          });
        </script>

    </head>
    
 
    <body>
         <c:set var="contextPath" value="${pageContext.request.contextPath}" />
	<div align="center">
		<h2>Edit Leave</h2>
		<form:form modelAttribute="leave" action="${contextPath}/associate/editLeaves.htm" method="post">
                      <input type="hidden" value="${leave.id}" name="id"/>
			<table class="login">
                                 <tr>
					<td>Start Date</td>
					<td><input id="start_date" type="date" name="start_date" 
							value="${leave.start_date}" /> <font color="red"><form:errors
								path="start_date" /></font></td>
				</tr>
                                 <tr>
					<td>End Date:</td>
					<td><input id="end_date" name="end_date" type="date"
							value="${leave.end_date}"  /> <font color="red"><form:errors
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

