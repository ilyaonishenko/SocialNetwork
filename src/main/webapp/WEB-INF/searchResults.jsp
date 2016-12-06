<%@ page import="model.Post" %>
<%@ page import="model.User" %>
<%@ page import="model.Comment" %>
<%@ page import="java.util.ArrayList" %>
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
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/page.css'/>"/>
</head>
<body>
<%--<h5>USERS</h5>--%>
<%--<% ArrayList<User> users = (ArrayList<User>) possibleUsers;%>--%>
<%--<% for (User u: users){%>--%>
<%--<br><%=u%>--%>
<%--<%}%>--%>
<%--<hr>--%>
<%--<h5>POSTS</h5>--%>
<%--<% ArrayList<Post> posts = (ArrayList<Post>) possiblePosts;%>--%>
<%--<% for (Post p: posts){%>--%>
<%--<br><%=p%>--%>
<%--<%}%>--%>
<%--<hr>--%>
<%--<h5>COMMENTS</h5>--%>
<%--<% ArrayList<Comment> comments = (ArrayList<Comment>) possibleComments;%>--%>
<%--<% for (Comment c: comments){%>--%>
<%--<br> <%=c%>--%>
<%--<%}%>--%>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <jsp:include page="common/logged_navbar.jsp"/>
                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="row">
                            <%--right--%>
                            <div class="col-sm-7" id="follows">
                                <div class="well">
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
