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
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" id="brand" href="/">Texter</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="/login" ><fmt:message key="header.login"/></a></li>
            <li><a href="/register" ><fmt:message key="header.register"/></a></li>
            <li><a href="/changelocale" >EN/RU</a></li>
        </ul>
    </div>
</nav>
