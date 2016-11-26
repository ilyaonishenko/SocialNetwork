<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 26.11.16
  Time: 16:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<html>
<head>
    <title>Update profile</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='../../resources/js/bootstrap.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/moment.min.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
</head>
<jsp:useBean id="sUser" scope="session" type="model.User"/>
<body>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <jsp:include page="../common/logged_navbar.jsp"/>
                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="row">
                            <%--left--%>
                            <div class="col-sm-5" id="updateprofile">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4>Update profile information</h4>
                                    </div>
                                    <div class="panel-body">
                                        <c:if test="${updated == true}">
                                            <div role="alert" class="alert alert-dismissible alert-success fade in">
                                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                                <strong>Well done!</strong> Information is updated.
                                            </div>
                                        </c:if>
                                        <div class="panel-thumbnail">
                                            <img style="border-radius: 50%; margin-left: auto; margin-right: auto; float: none;" src="../../resources/img/quest.gif" class="img-responsive">
                                        </div>
                                        <br>
                                        <div>
                                            <form class="form-horizontal" action="/s/updateprofile" method="post">
                                                <fieldset>
                                                    <div class="form-group">
                                                        <label for="inputEmail" class="col-lg-2 control-label"><fmt:message key="register.email"/>:</label>
                                                        <div class="col-lg-10">
                                                            <input name="email" type="text" class="form-control"
                                                                   id="inputEmail" value="${sUser.email}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputFirstName" class="col-lg-2 control-label"><fmt:message key="register.first_name"/>:</label>
                                                        <div class="col-lg-10">
                                                            <input name="firstName" type="text" class="form-control"
                                                                   id="inputFirstName" value="${sUser.firstName}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="inputLastName" class="col-lg-2 control-label"><fmt:message key="register.last_name"/>:</label>
                                                        <div class="col-lg-10">
                                                            <input name="lastName" type="text" class="form-control"
                                                                   id="inputLastName" value="${sUser.lastName}">
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="col-lg-10 col-lg-offset-2">
                                                            <button type="reset" class="btn btn-default"><fmt:message key="button.cancel"/></button>
                                                            <button value="submit" type="submit" class="btn btn-primary"><fmt:message key="button.submit"/></button>
                                                        </div>
                                                    </div>
                                                </fieldset>
                                            </form>
                                        <%--<div style="float: right">--%>
                                            <%--<p class="lead">${user.user.firstName} ${user.user.lastName}</p>--%>
                                            <%--<p>description about this guy</p>--%>
                                            <%--<a id="followButton" class="btn btn-primary"--%>
                                               <%--onclick="follow.followClick('${user.user.username}')">Follow</a>--%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%--left ended--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
