<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 03.11.16
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Following</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='../../resources/js/scripts.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
</head>
<body>
<jsp:useBean id="user" type="model.User" scope="request"/>
<jsp:useBean id="followings" class="java.util.HashSet" scope="request"/>

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
                            <%--right--%>
                            <div class="col-sm-7" id="follows">
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <p class="lead">${user.username} <fmt:message key="followings.followings"/> </p>
                                    </div>
                                </div>
                            </div>
                            <%--<% for (User u : followingUsers) {%>--%>
                                <c:forEach items="${followings}" var="follow">
                                    <div class="col-sm-7" id="follows">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <div class="commenterImage"><img src="../../resources/img/quest.gif">
                                                </div>
                                                <h4><a href="/user/${follow.username}">${follow.username}
                                                </a></h4>
                                                <a style="float: right; margin-top: -35px;"
                                                   id="followButton${follow.username}" class="btn btn-primary"
                                                   onclick="FollowThings.followClick('${follow.username}')">Follow</a>
                                            </div>
                                            <div class="panel-body">
                                                    ${follow.firstName} ${follow.lastName}
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
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
    <c:forEach items="${followings}" var="following">
    $('#${following.username}').ready(function () {
        FollowThings.doStuff('${following.username}', visitor = "${sUser.username}");
    });
    </c:forEach>
</script>
</html>
