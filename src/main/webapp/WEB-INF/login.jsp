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
<fmt:setLocale value="${locale}" scope="session"/>
<script>
    console.log('${locale}');
    sessionStorage.setItem('locale','${locale}');
</script>
<html>
<head>
    <title>Login</title>

    <link rel="stylesheet" href="<c:url value='../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../resources/css/registerPage.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../resources/css/navbar.css'/>"/>
</head>
<body>
<header>
    <jsp:include page="common/loggedOut_navbar.jsp"/>
</header>
<form id="form" class="form-horizontal" action="/login" method="post">
    <fieldset>
        <legend><fmt:message key="login.title"/></legend>
        <div class="form-group">
            <div class="col-lg-10">
                <input name="j_username" type="text" class="form-control" id="inputUsername" placeholder="<fmt:message key="login.username"/>">
            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-10">
                <input name="j_password" type="password" class="form-control" id="inputPassword" placeholder="<fmt:message key="login.password"/>">
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
