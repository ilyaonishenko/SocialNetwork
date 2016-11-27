<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 15.11.16
  Time: 1:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="locale" scope="session" class="java.lang.String"/>
<fmt:setLocale value="${locale}" scope="session"/>
<jsp:useBean id="sUser" type="model.User" scope="session"/>
<%--<nav class="navbar navbar-default">--%>
    <%--<div class="container-fluid">--%>
        <%--<div class="navbar-header">--%>
            <%--<a class="navbar-brand" id="brand" href="/">Texter</a>--%>
        <%--</div>--%>
        <%--<ul class="nav navbar-nav navbar-left">--%>
            <%--<li><a href="/user/"><fmt:message key="header.profile"/></a></li>--%>
            <%--<li><a href="/home/"><fmt:message key="header.home"/></a> </li>--%>
            <%--<li><a href="#"><fmt:message key="header.post"/></a></li>--%>
        <%--</ul>--%>
        <%--<ul class="nav navbar-nav navbar-right">--%>
            <%--<li><a href="/changelocale" >EN/RU</a></li>--%>
            <%--<li><a href="/logout"><fmt:message key="header.logout"/></a></li>--%>
        <%--</ul>--%>
    <%--</div>--%>
<%--</nav>--%>
<div class="navbar navbar-blue navbar-static-top">
    <div class="navbar-header">
        <a href="/" class="navbar-brand">Texter</a>
    </div>
    <nav class="collapse navbar-collapse" role="navigation">
        <form class="navbar-form navbar-left">
            <div class="input-group input-group-sm" style="max-width:360px;">
                <input type="text" class="form-control" placeholder="<fmt:message key="header.search"/>" name="srch-term" id="srch-term">
                <div class="input-group-btn">
                    <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
        </form>
        <ul class="nav navbar-nav">
            <li>
                <a href="/home/"><i class="glyphicon glyphicon-home"></i> <fmt:message key="header.home"/></a>
            </li>
            <li>
                <a href="#postModal" role="button" data-toggle="modal"><i class="glyphicon glyphicon-plus"></i> <fmt:message key="header.post"/></a>
            </li>
            <li>
                <a href="/user/${sUser.username}"><i class="glyphicon glyphicon-user"></i> <fmt:message key="header.profile"/></a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="/changelocale">EN/RU</a>
            </li>
            <li>
                <a href="/logout"><i class="glyphicon glyphicon-log-out"></i> <fmt:message key="header.logout"/></a>
            </li>
        </ul>
    </nav>
</div>
<div id="postModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                Update Status
            </div>
            <form class="form center-block" role="form" method="post" action="/s/createpost">
            <div class="modal-body">
                    <div class="form-group">
                        <textarea class="form-control input-lg" name="post" autofocus="" placeholder="Say something kind"></textarea>
                        <%--<input type="checkbox" name="privacy" class="sub-text">Privacy</input>--%>
                    </div>
            </div>
            <div class="modal-footer">
                <div>
                    <button value="submit" type="submit" class="btn btn-primary btn-sm"  aria-hidden="true">Post</button>
                    <ul class="pull-left list-inline">
                        <li>
                            <div>
                                <input name="privacy" type='checkbox' id='checkbox-1' class='tags-checkbox sr-only'/>
                                <label for='checkbox-1'>
                                    <i class='glyphicon glyphicon-eye-open'></i>
                                    <i class='glyphicon glyphicon-eye-close'></i>
                                    <span class='sub-text'>privacy</span>
                                </label>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
            </form>
        </div>
    </div>
</div>