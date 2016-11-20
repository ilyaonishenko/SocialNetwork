<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 20.11.16
  Time: 3:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="postView" type="model.PostView" scope="request"/>
<html>
<head>
    <title>Post</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
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
                                <div class="col-sm-7">
                                    <div class="panel panel-default" id="${postView.post.id}">
                                        <div class="panel panel-heading">
                                            <h4>
                                                <a href='/user/${postView.user.username}'>@${postView.user.username}</a>
                                            </h4>
                                        </div>
                                        <div class="panel panel-body" id="${postView.post.id}">
                                            <p/>${postView.post.text}
                                            <hr>
                                            <div style="text-align: right">
                                                ${postView.post.time} ${postView.post.date}
                                            </div>
                                                <button>${postView.likesCount}</button>
                                        </div>
                                        <div class="panel panel-footer">
                                            <p/> Hello world!
                                        </div>
                                    </div>
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
</html>
