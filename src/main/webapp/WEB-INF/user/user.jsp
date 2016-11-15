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
<html>
<head>
    <title>${user.username}</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
</head>
<body>
<header>
    <c:choose>
        <c:when test="${not (empty sUser)}">
            <jsp:include page="../common/logged_navbar.jsp"/>
        </c:when>
        <c:otherwise>
            <jsp:include page="../common/loggedOut_navbar.jsp"/>
        </c:otherwise>
    </c:choose>
</header>
<p/>Hello, ${user.firstName} ${user.lastName}
<a id="followButton" class="btn btn-primary" onclick="follow.followClick('${user.username}')">Follow</a>
<div id="posts">
</div>
</body>
<script>
    var follow = new FollowThings(username = "${user.username}", visitor = ${sUser.username});
    var postHandler = new PostHandler(userId = "${user.id}", visitorId = "${sUser.id}",
            postContainer = document.getElementById("posts"));
    addEventListener ("DOMContentLoaded", follow.doStuff, false);
    addEventListener ("DOMContentLoaded", postHandler.loadUserPosts, false)
</script>
</html>
