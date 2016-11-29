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
<jsp:useBean id="user" type="model.UserView" scope="request"/>
<html>
<head>
    <title>${user.user.username}</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='../../resources/js/scripts.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/moment.min.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
</head>
<body>
<%--<div id="user-info">--%>
    <%--<div id="user-container">--%>
        <%--<img id="profile-img" src="../../resources/img/quest.gif" alt="avatar" style="width:130px;height:130px;">--%>
        <%--<div id="user-text">--%>
            <%--<h3>${user.firstName} ${user.lastName}</h3><br>--%>
            <%--<h4>@${user.username}</h4>--%>
        <%--</div>--%>
    <%--</div>--%>
    <%--<div id="controls">--%>
        <%--<ul class="nav nav-pills">--%>
            <%--<li class="active"><a href="#">Posts <span class="badge">42</span></a></li>--%>
            <%--<li><a href="/WEB-INF/user/following.jsp">Following <span class="badge">2</span></a></li>--%>
            <%--<li><a href="/WEB-INF/user/followers.jsp">Followers <span class="badge">3</span></a></li>--%>
        <%--</ul>--%>
    <%--</div>--%>
<%--</div>--%>
<%--<p/>Hello, ${user.firstName} ${user.lastName}--%>
<%--<a id="followButton" class="btn btn-primary" onclick="follow.followClick('${user.username}')">Follow</a>--%>
<%--<div id="last_activity">--%>
    <%--<p/>No last activity--%>
<%--</div>--%>
<%--<div id="posts">--%>
<%--</div>--%>
<%--<div id="recommendations">--%>

<%--</div>--%>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <c:choose>
                    <c:when test="${not (empty sUser)}">
                        <jsp:include page="../common/logged_navbar.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="../common/loggedOut_navbar.jsp"/>
                    </c:otherwise>
                </c:choose>
                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="row">
                            <%--left--%>
                            <div class="col-sm-5">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4>
                                            <a href="/user/${user.user.username}">@${user.user.username}</a>
                                            <c:if test="${sUser.id == user.user.id}">
                                                <a href="<c:url value="/s/updateprofile"/>">
                                                    <i class="glyphicon glyphicon-cog" style="float: right;"></i>
                                                </a>
                                            </c:if>
                                        </h4>
                                    </div>
                                    <div class="panel-body">
                                        <div style="border-radius: 30%; float: left" class="panel-thumbnail">
                                            <img src="../../resources/img/quest.gif" class="img-responsive">
                                        </div>
                                        <div style="float: right">
                                            <p class="lead">${user.user.firstName} ${user.user.lastName}</p>
                                            <p>description about this guy</p>
                                            <a id="followButton${user.user.username}" class="btn btn-primary"
                                               onclick="follow.followClick('${user.user.username}')">Follow</a>
                                            <c:if test="${userRoles.size()==3}">
                                                <form style="margin-right: auto; margin-left: auto" action="<c:url value="/s/deleteuser"/>" method="post">
                                                    <input hidden="hidden" value="${user.user.username}" name="d_username">
                                                    <button value="submit" type="submit" class="btn btn-danger">
                                                        Delete page
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="panel-footer">
                                        <ul id="pff">
                                            <li><h5 class="badge"><a href="/user/${user.user.username}">posts: ${user.posts}</a> </h5></li>
                                            <li><h5 class="badge"><a href="/followings/${user.user.username}">following: ${user.followings}</a></h5></li>
                                            <li><h5 class="badge"><a href="/followers/${user.user.username}">followers: ${user.followers}</a></h5></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="panel panel-default" >
                                    <div class="panel-heading"><h4>Recommendations</h4></div>
                                    <div class="panel-body">
                                        And so on
                                    </div>
                                </div>
                            </div>
                            <%--left ended--%>
                            <%--right--%>
                            <div class="col-sm-7">
                                <div id="posts">

                                </div>
                                <%--<c:choose>--%>
                                    <%--<c:when test="${not (empty sUser)}">--%>
                                        <%--<jsp:include page="../common/logged_postview.jsp"/>--%>
                                    <%--</c:when>--%>
                                    <%--<c:otherwise>--%>
                                        <%--<jsp:include page="../common/loggedOut_postview.jsp"/>--%>
                                    <%--</c:otherwise>--%>
                                <%--</c:choose>--%>
                            </div>
                            <%--right ended--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    var follow = new FollowThings(username = "${user.user.username}", visitor = "${sUser.username}");
    addEventListener ("DOMContentLoaded", follow.doStuff, false);
    <%--var liker = new Like('${sUser.id}');--%>
    let visitorId = "${sUser.id}";
    <c:if test="${userRoles.size()>1}">
        visitorId = "${user.user.id}";
    </c:if>
    var postHandler = new PostHandler(userId = "${user.user.id}", visitorId,
            postContainer = document.getElementById("posts"));
    addEventListener ("DOMContentLoaded", postHandler.loadUserPosts, false)
</script>
</html>
