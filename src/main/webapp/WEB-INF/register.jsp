<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="locale" scope="session" class="java.lang.String"/>
<fmt:setLocale value="${locale}" scope="application"/>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="<c:url value='../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../resources/css/registerPage.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../resources/css/navbar.css'/>"/>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" id="brand" href="/">Texter</a>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">EN/RU</a></li>
        </ul>
    </div>
</nav>
<form class="form-horizontal" action="/register" method="post">
    <fieldset>
        <legend><fmt:message key="register.title"/></legend>
        <div class="form-group">
            <label for="inputUsername" class="col-lg-2 control-label"><fmt:message key="register.username"/>:</label>
            <div class="col-lg-10">
                <input name="j_username" type="text" class="form-control"
                       id="inputUsername" placeholder="<fmt:message key="register.username"/>">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail" class="col-lg-2 control-label"><fmt:message key="register.email"/>:</label>
            <div class="col-lg-10">
                <input name="email" type="text" class="form-control"
                       id="inputEmail" placeholder="<fmt:message key="register.email"/>">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword" class="col-lg-2 control-label"><fmt:message key="register.password"/>:</label>
            <div class="col-lg-10">
                <input name="j_password" type="password" class="form-control"
                       id="inputPassword" placeholder="<fmt:message key="register.password"/>">
            </div>
        </div>
        <div class="form-group">
            <label for="inputFirstName" class="col-lg-2 control-label"><fmt:message key="register.first_name"/>:</label>
            <div class="col-lg-10">
                <input name="firstName" type="text" class="form-control"
                       id="inputFirstName" placeholder="<fmt:message key="register.first_name"/>">
            </div>
        </div>
        <div class="form-group">
            <label for="inputLastName" class="col-lg-2 control-label"><fmt:message key="register.last_name"/>:</label>
            <div class="col-lg-10">
                <input name="lastName" type="text" class="form-control"
                       id="inputLastName" placeholder="<fmt:message key="register.last_name"/>">
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

</body>
</html>
