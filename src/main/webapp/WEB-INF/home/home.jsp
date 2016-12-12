<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 31.10.16
  Time: 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script type="text/javascript" src="<c:url value="../../resources/js/moment.min.js"/>"></script>
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
                            <div class="col-sm-7" id="follows">
                                <div class="well">
                                    <form class="form-horizontal" role="form" method="post"
                                          action="<c:url value="/s/createpost"/>">
                                        <h4><fmt:message key="home.whats"/></h4>
                                        <div class="form-group" style="padding:14px;">
                                            <textarea class="form-control" name="post"
                                                      placeholder="<fmt:message key="post.saysomething"/>"></textarea>
                                            <%--<input type="checkbox" name="privacy" class="sub-text">Privacy</input>--%>
                                        </div>
                                        <button class="btn btn-primary pull-right" value="submit" type="submit">
                                            <fmt:message key="header.post"/>
                                        </button>
                                        <ul class="list-inline">
                                            <li>
                                                <div id="costyl">
                                                    <input name="privacy" type='checkbox' id='checkbox-2'
                                                           class='tages-checkbox sr-only'/>
                                                    <label for='checkbox-2'>
                                                        <i class='glyphicon glyphicon-eye-open'></i>
                                                        <i class='glyphicon glyphicon-eye-close'></i>
                                                        <span class='sub-text'><fmt:message
                                                                key="home.privacy"/> </span>
                                                    </label>
                                                </div>
                                            </li>
                                        </ul>
                                    </form>
                                </div>
                                <input id="costyl3" hidden="hidden"/>
                                <input id="sizeOfDiv" hidden="hidden" value="0"/>
                                <input id="maxSizeOfDiv" hidden="hidden" value="0"/>
                                <div id="timeline">

                                </div>
                                <a id="buttonMore" style=" display:none; margin-left: auto; margin-right: auto" onclick="loadMore()" class="btn btn-info">
                                <fmt:message key="post.loadmore"/>
                            </a>
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
    let userId = '${user.id}';
    let postContainer  = document.getElementById('timeline');
    let isAdmin = false;
    
    <c:if test="${userRoles.size()>1}">
        isAdmin = true;
    </c:if>
    
    let timeline = new Timeline(userId, postContainer, isAdmin);
    function changePrivacy(label) {
        if(label.innerHTML == "<i class='glyphicon glyphicon-eye-open'></i>"){
            label.innerHTML = "<i class='glyphicon glyphicon-eye-close'></i>"
        } else {
            label.innerHTML = "<i class='glyphicon glyphicon-eye-open'></i>";
        }
    }
    addEventListener("DOMContentLoaded", timeline.loadTimeline, false);
    addEventListener("DOMContentLoaded", timeline.countAllPosts, false);
    function loadMore() {
        timeline.loadPrevTimeline();
    }
</script>
</html>
