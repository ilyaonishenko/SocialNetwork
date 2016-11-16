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
                <a href="#"><i class="glyphicon glyphicon-plus"></i> <fmt:message key="header.post"/></a>
            </li>
            <li>
                <a href="/user/"><i class="glyphicon glyphicon-user"></i> <fmt:message key="header.profile"/></a>
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
