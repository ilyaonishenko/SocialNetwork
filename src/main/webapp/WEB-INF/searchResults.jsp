<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 05.12.16
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="possibleUsers" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="possiblePosts" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="possibleComments" class="java.util.ArrayList" scope="request"/>
<html>
<head>
    <title>SEARCH RESULTS</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/bootstrap.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value='../../resources/js/scripts.js'/>"></script>
    <script type="text/javascript" src="<c:url value='../../resources/js/userScript.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
</head>
<body>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <jsp:include page="common/logged_navbar.jsp"/>
                <div class="row">
                    <div class="col-sm-3">
                        <a href="#" class="nav-tabs-dropdown btn btn-block btn-primary"><fmt:message key="search.tabs"/> </a>
                        <ul id="nav-tabs-wrapper" class="nav nav-tabs nav-pills nav-stacked well">
                            <li class="active"><a href="#vtab1" data-toggle="tab"><fmt:message key="search.users"/></a></li>
                            <li><a href="#vtab2" data-toggle="tab"><fmt:message key="search.posts"/></a></li>
                            <li><a href="#vtab3" data-toggle="tab"><fmt:message key="search.comments"/></a></li>
                        </ul>
                    </div>
                    <div class="col-sm-7">
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane fade in active" id="vtab1">
                                <h3>Tab 1</h3>
                                <c:if test="${possibleUsers.size() != 0}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <p class="lead"><fmt:message key="search.users"/></p>
                                        </div>
                                    </div>
                                    <c:forEach items="${possibleUsers}" var="user">
                                        <div class="panel panel-default" id="'${user.username}'">
                                            <div class="panel-heading">
                                                <div class="commenterImage"><img
                                                        src="../../resources/img/quest.gif"></div>
                                                <h4><a href="/user/${user.username}">${user.username}
                                                </a></h4>
                                                    <a style="float: right; margin-top: -35px;"
                                                    id="followButton${user.username}" class="btn btn-primary"
                                                    onclick="FollowThings.followClick('${user.username}')">Follow</a>
                                            </div>
                                            <div class="panel-body">
                                                    ${user.firstName} ${user.lastName}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div role="tabpanel" class="tab-pane fade in" id="vtab2">
                                <h3>Tab 2</h3>
                                <c:if test="${possiblePosts.size() != 0}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <p class="lead"><fmt:message key="search.posts"/></p>
                                        </div>
                                    </div>
                                    <c:forEach items="${possiblePosts}" var="postView">
                                        <div class="panel panel-default" id="'${postView.post.id}'">
                                            <div class="panel-heading">
                                                <a href="/post/${postView.post.id}" class="pull-right"
                                                   style="margin-top: 5px"><fmt:message key="post.openPost"/></a>
                                                <h4>
                                                    <a href="/user/${postView.user.username}">@${postView.user.username}
                                                    </a></h4>
                                            </div>
                                            <div class="panel-body" id="${postView.post.id}">
                                                <p>${postView.post.text}</p>
                                                <hr>
                                                <div style="text-align: right;">
                                                        ${postView.post.time}<br>${postView.post.date}
                                                </div>
                                                <%--<form>--%>
                                                    <%--<div class="input-group">--%>
                                                        <%--<div class="input-group-btn" id="$${postView.post.id}">--%>
                                                            <%--<button id="likes" class="btn btn-default"--%>
                                                                    <%--onclick="Like.makeLike('${sUser.id}','${postView.post.id}', document.getElementById('$${postView.post.id}'))">--%>
                                                                <%--+${postView.likesCount}</button>--%>
                                                        <%--</div>--%>
                                                    <%--</div>--%>
                                                <%--</form>--%>
                                                <div style="float:right;">
                                                    comments: ${postView.commentsCount}</div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div role="tabpanel" class="tab-pane fade in" id="vtab3">
                                <h3>Tab 3</h3>
                                <c:if test="${possibleComments.size() !=0}">
                                    <div class="panel panel-default">
                                        <div class="panel-body">
                                            <p class="lead"><fmt:message key="search.comments"/></p>
                                        </div>
                                    </div>
                                    <c:forEach items="${possibleComments}" var="comment">
                                        <div class="panel panel-default" id="'${comment.id}'">
                                            <div class="panel-heading">
                                                <a href="/post/${comment.postId}" class="pull-right"
                                                   style="margin-top: 5px"><fmt:message key="post.openPost"/></a>
                                                <h4><a href="/user/${comment.username}">@${comment.username}
                                                </a></h4>
                                            </div>
                                            <div class="panel-body">
                                                <p>${comment.text}</p>
                                                <hr>
                                                <div style="text-align: right;">
                                                        ${comment.time}<br>${comment.date}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    <c:forEach items="${possibleUsers}" var="following">
        $('#${following.username}').ready(function () {
        FollowThings.doStuff('${following.username}', visitor = "${sUser.username}");
        });
    </c:forEach>
</script>
</html>
