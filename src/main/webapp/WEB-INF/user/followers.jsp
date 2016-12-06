<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 03.11.16
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Followers</title>
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
<jsp:useBean id="followers" class="java.util.HashSet" scope="request"/>

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
                                            <p class="lead">${user.username}: <fmt:message key="followers.followers"/> </p>
                                        </div>
                                    </div>
                                </div>
                                <c:forEach items="${followers}" var="follower">
                                <div class="col-sm-7" id="follows">
                                    <div class="panel panel-default" id="'${follower.username}'">
                                        <div class="panel-heading">
                                            <div class="commenterImage"><img src="../../resources/img/quest.gif"></div>
                                            <h4><a href="/user/${follower.username}">${follower.username}
                                            </a></h4>
                                            <a style="float: right; margin-top: -35px;"
                                               id="followButton${follower.username}" class="btn btn-primary"
                                               onclick="FollowThings.followClick('${follower.username}')">Follow</a>
                                        </div>
                                        <div class="panel-body">
                                                ${follower.firstName} ${follower.lastName}
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
    <c:forEach items="${followers}" var="follower">
        $("#${follower.username}").ready(function () {
            FollowThings.doStuff('${follower.username}', visitor = "${sUser.username}");
        });
    </c:forEach>
</script>
</html>
