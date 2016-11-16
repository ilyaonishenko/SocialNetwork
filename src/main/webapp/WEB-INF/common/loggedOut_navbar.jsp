<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 15.11.16
  Time: 1:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="locale" scope="session" class="java.lang.String"/>
<fmt:setLocale value="${locale}" scope="session"/>
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
        <ul class="nav navbar-nav navbar-right">
            <li>
                <a href="/register"><i class="glyphicon glyphicon-home"></i> <fmt:message key="header.register"/></a>
            </li>
            <li>
                <a href="/login"><i class="glyphicon glyphicon-plus"></i> <fmt:message key="header.login"/></a>
            </li>
            <li>
                <a href="/changelocale"> EN/RU</a>
            </li>
        </ul>
    </nav>
</div>
