<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 31.10.16
  Time: 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.UserRole" %>
<%@ page import="java.util.HashSet" %>
<jsp:useBean id="user" type="model.User" scope="request"/>
<jsp:useBean id="userRoles" class="java.util.HashSet" scope="request"/>
<html>
<head>
    <title>HomePage</title>
    <%--<% HashSet<User> roles = (HashSet<String>)session.getAttribute("ROLE");%>--%>
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
<%--Welcome to your homePage, <%=user.getFirstName()%>!--%>
<%--<br>--%>
<%--Your role in this project: <br>--%>
<%--<% HashSet<UserRole> roles = (HashSet<UserRole>) userRoles;%>--%>
<%--<% for(UserRole role: roles){%>--%>
<%--<br><%=role%>--%>
<%--<%}%>--%>
<%--<br>--%>
<%--<p>timeline:</p>--%>
<%--<div id="timeline"></div>--%>

<%--<form action="/s/createpost" method="post">--%>
    <%--<label>Write your text here</label>--%>
    <%--<input id="text" name="post" type="text">--%>
    <%--<label>Expandable: </label>--%>
    <%--<input name = 'expandable' type="checkbox">--%>
    <%--<label>Private:</label>--%>
    <%--<input name = 'privacy' type="checkbox">--%>
    <%--<button type="submit" value="submit">Post</button>--%>
<%--</form>--%>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <jsp:include page="../common/logged_navbar.jsp"/>
                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="row">
                            <%--right--%>
                            <div class="col-sm-7">
                                <div class="well">
                                    <form class="form-horizontal" role="form" method="post" action="/s/createpost">
                                        <h4>What's New</h4>
                                        <div class="form-group" style="padding:14px;">
                                            <textarea class="form-control" name="post" placeholder="Say something kind"></textarea>
                                            <input type="checkbox" name="privacy" class="sub-text">Privacy</input>
                                        </div>
                                        <button class="btn btn-primary pull-right" value="submit" type="submit">Post</button><ul class="list-inline"><li><a href=""><i class="glyphicon glyphicon-upload"></i></a></li><li><a href=""><i class="glyphicon glyphicon-camera"></i></a></li><li><a href=""><i class="glyphicon glyphicon-map-marker"></i></a></li></ul>
                                    </form>
                                </div>
                                <div id="timeline">

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
<script>
    var userId = '${user.id}';
    var postContainer  = document.getElementById('timeline');
    var timeline = new Timeline(userId, postContainer);
    <%--function post(form) {--%>
        <%--console.log("we are going to post a post");--%>
        <%--var text = form.text.value;--%>
        <%--console.log("with text: "+text);--%>
        <%--$.ajax({--%>
            <%--url: '/webapi/posts/add',--%>
            <%--type: 'POST',--%>
            <%--data: {--%>
                <%--'userId': '${sUser.id}',--%>
                <%--'text': text,--%>
                <%--'privacy': false,--%>
                <%--'expandable': false--%>
            <%--},--%>
            <%--contentType: 'application/json',--%>
            <%--dataType: "json",--%>
            <%--success: function (answer) {--%>
                <%--window.location.reload();--%>
            <%--}--%>
        <%--})--%>
    <%--}--%>
    addEventListener("DOMContentLoaded", timeline.loadTimeline, false);
</script>
</html>
