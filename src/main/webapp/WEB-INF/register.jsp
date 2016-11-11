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
        <legend>Registration</legend>
        <div class="form-group">
            <label for="inputUsername" class="col-lg-2 control-label">Username:</label>
            <div class="col-lg-10">
                <input name="j_username" type="text" class="form-control" id="inputUsername" placeholder="Username">
            </div>
        </div>
        <div class="form-group">
            <label for="inputEmail" class="col-lg-2 control-label">Email:</label>
            <div class="col-lg-10">
                <input name="email" type="text" class="form-control" id="inputEmail" placeholder="Email">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword" class="col-lg-2 control-label">Password:</label>
            <div class="col-lg-10">
                <input name="j_password" type="password" class="form-control" id="inputPassword" placeholder="Password">
            </div>
        </div>
        <div class="form-group">
            <label for="inputFirstName" class="col-lg-2 control-label">First name:</label>
            <div class="col-lg-10">
                <input name="firstName" type="text" class="form-control" id="inputFirstName" placeholder="Firstname">
            </div>
        </div>
        <div class="form-group">
            <label for="inputLastName" class="col-lg-2 control-label">Last name:</label>
            <div class="col-lg-10">
                <input name="lastName" type="text" class="form-control" id="inputLastName" placeholder="Lastname">
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-10 col-lg-offset-2">
                <button type="reset" class="btn btn-default">Cancel</button>
                <button value="submit" type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </fieldset>
</form>

</body>
</html>
