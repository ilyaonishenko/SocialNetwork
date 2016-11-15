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
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" id="brand" href="/">Texter</a>
        </div>
        <ul class="nav navbar-nav navbar-left">
            <li><a href="/user/"><fmt:message key="header.profile"/></a></li>
            <li><a href="/home/"><fmt:message key="header.home"/></a> </li>
            <li><a href="#"><fmt:message key="header.post"/></a></li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/changelocale" >EN/RU</a></li>
            <li><a href="/logout"><fmt:message key="header.logout"/></a></li>
        </ul>
    </div>
</nav>
