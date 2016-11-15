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
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
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
<div id="user-info">
    <div id="user-container">
        <img id="profile-img" src="../../resources/img/quest.gif" alt="avatar" style="width:130px;height:130px;">
        <div id="user-text">
            <h3>${user.firstName} ${user.lastName}</h3><br>
            <h4>@${user.username}</h4>
        </div>
    </div>
    <div id="controls">
        <ul class="nav nav-pills">
            <li class="active"><a href="#">Posts <span class="badge">42</span></a></li>
            <li><a href="/WEB-INF/user/following.jsp">Following <span class="badge">2</span></a></li>
            <li><a href="/WEB-INF/user/followers.jsp">Followers <span class="badge">3</span></a></li>
        </ul>
    </div>
</div>
<p/>Hello, ${user.firstName} ${user.lastName}
<a id="followButton" class="btn btn-primary" onclick="follow.followClick('${user.username}')">Follow</a>
<div id="last_activity">
    <p/>No last activity
</div>
<div id="posts">
</div>
<div id="recommendations">

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
