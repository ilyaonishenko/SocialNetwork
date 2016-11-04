<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.User" %>
<html>
<head>
    <title>YO!</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/registerPage.css'/>"/>
</head>
<jsp:useBean id="user" type="model.User" scope="request"/>
<body>
<p/>Hello, <%=user.getFirstName()%> <%=user.getLastName()%>

<a class="btn btn-primary" onclick="followClick(<%=user.getId()%>)">Follow</a>
</body>
<script>
    function followClick(data) {
//        alert(data);
        $.ajax({
            url: "/s/follow/",
            type: "POST",
            data: {'followId':data},
            success: function (data) {
                alert(data);
            },
            error: function (e) {
                alert("Error!");
            }
        });
    }
</script>
</html>
