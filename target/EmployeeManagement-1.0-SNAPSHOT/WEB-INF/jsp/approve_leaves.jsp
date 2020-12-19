<%-- 
    Document   : approve_leaves
    Created on : Dec 12, 2020, 2:49:46 PM
    Author     : Sindhu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style><%@include file="/resources/css/style.css"%></style>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>
        <c:set var="contextPath" value="${pageContext.request.contextPath}" />
        <c:set var="leaveList" value="${leaveList}" />
        <nav class="navbar navbar-inverse" style="height:70px">
            <p style="text-align: center;font-size: 40px;color:white;font-weight: bold">Employee Management Portal</p>
             <p style="text-align: right;font-size: 20px;font-weight: bold">Hello ${user.first_name}${user.last_name} </p>
            <ul class="nav navbar-nav" style="float:right">
                <li><a href="${pageContext.request.contextPath}/manager/list_tasks.htm">View/Add Tasks</a></li>
                <li><a href="${pageContext.request.contextPath}/manager/approve_leaves.htm">Leave Approval</a></li>
                <li><a href="${pageContext.request.contextPath}">Logout</a></li>
            </ul>
        </nav>
        <div align="center" style="margin-top: 250px">
           <c:if test="${not empty errorMessage}">
                    <p style="color:red">${errorMessage}</p>
             </c:if>
            <table class="table table-striped" id="emp-table">
                <thead>
                <th>Employee Name</th>
                <th>Reason</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Approve/Reject</th>
                </thead>
                <c:forEach items="${leaveList}" var="leave">
                    <form action="${contextPath}/manager/approve_leaves.htm" method="post">
                        <input type="hidden" value="${leave.id}" name="id"/>	
                        <tr>
                            <td>${leave.user.first_name} ${leave.user.last_name}</td>
                            <td>${leave.reason}</td>
                            <td>${leave.start_date}</td>
                            <td>${leave.end_date}</td>
                            <td>${leave.status}</td>
                            <c:if test="${leave.status=='Applied'}">
                                <td><input class="btn btn-success"  type="submit"
                                           name="action" value="Approve" >
                                    <input type="submit" class="btn btn-danger" name="action" value="Reject"></td>
                                </c:if>
                                <c:if test="${leave.status=='Approve'}">
                                <td><input class="btn btn-success"  type="submit"
                                           name="action" value="Approve" disabled="disabled">
                                    <input type="submit" class="btn btn-danger"  name="action" value="Reject"></td>
                                </c:if>
                                <c:if test="${leave.status=='Reject'}">
                                <td><input class="btn btn-success" type="submit"
                                           name="action" value="Approve">
                                    <input type="submit" class="btn btn-danger"  name="action" value="Reject" disabled="disabled"></td> 
                                </c:if>
                        </tr>
                    </form>
                </c:forEach>

            </table>
        </div>
    </body>
</html>
