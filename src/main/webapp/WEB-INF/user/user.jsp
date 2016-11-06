<%--suppress BadExpressionStatementJS --%>
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
<jsp:useBean id="user" type="model.User" scope="request"/>
<% User visitor = (User) session.getAttribute("user");%>
<html>
<head>
    <title><%=user.getUsername()%></title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/registerPage.css'/>"/>
</head>
<body>
<p/>Hello, <%=user.getFirstName()%> <%=user.getLastName()%>
<a id="followButton" class="btn btn-primary" onclick="follow.followClick('<%=user.getUsername()%>')">Follow</a>
<div id="posts">
</div>
</body>
<script>
    var follow = new FollowThings(username = "${user.username}", visitor = "<%= visitor.getUsername() %>");
    var postHandler = new PostHandler(userId = "${user.id}", visitorId = "<%= visitor.getId()%>",
            postContainer = document.getElementById("posts"));
    addEventListener ("DOMContentLoaded", follow.doStuff, false);
    addEventListener ("DOMContentLoaded", postHandler.loadUserPosts, false)
</script>
</html>
