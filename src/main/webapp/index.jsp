<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 18:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Texter</title>
    <link rel="stylesheet" href="<c:url value='resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='resources/css/mainPage.css'/>"/>
    <link rel="stylesheet" href="<c:url value='resources/css/navbar.css'/>"/>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" id="brand" href="#">Texter</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">EN/RU</a></li>
        </ul>
    </div>
</nav>
<div class="cont">
    <div class="jumbotron" id="main">
        <h3>We make the news real</h3>
        <p>Texter is the best social network to spread the news.</p>
        <p><a class="btn btn-primary btn-lg" href="/register">Join the Community!</a></p>
        <p/><a href="/login">Or login</a>
    </div>
</div>
</body>
</html>
