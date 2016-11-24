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
<jsp:useBean id="locale" scope="session" class="java.lang.String"/>
<fmt:setLocale value="${locale}" scope="session"/>
<html>
<script>
    console.log('${locale}');
    sessionStorage.setItem('locale','${locale}');
</script>
<head>
    <meta charset="utf-8">
    <title>Texter</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/mainPage.css'/>"/>
</head>
<body>
<c:choose>
    <c:when test="${not (empty sUser)}">
        <c:redirect url="/home/"/>
    </c:when>
    <c:otherwise>
        <div class="wrapper">
            <div class="box">
                <div class="row row-offcanvas row-offcanvas-left">
                    <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                        <jsp:include page="WEB-INF/common/loggedOut_navbar.jsp"/>
                        <div class="padding">
                            <div class="full col-sm-9">
                                <div class="row">
                                    <div class="col-sm-7">
                                        <div class="panel panel-default">
                                            <h2 class="">We run the news</h2>
                                            <div class="panel-body">
                                                <hr class="">
                                                <h3>Texter is the best social network to spread the news.</h3>
                                                <hr class="">
                                                <p><a class="btn btn-primary btn-lg" href="<c:url value="/register"/>"><fmt:message key="index.join"/></a>
                                                <h4><a href="<c:url value="/login"/>"><fmt:message key="index.login"/></a></h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
