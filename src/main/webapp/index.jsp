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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Texter</title>
    <link rel="stylesheet" href="<c:url value='resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='resources/css/cover.css'/>"/>
</head>
<body>

<div class="site-wrapper">

    <div class="site-wrapper-inner">

        <div class="cover-container">

            <div class="masthead clearfix">
                <div class="inner">
                    <h3 class="masthead-brand">Texter</h3>
                    <nav class="nav nav-masthead">
                    <a class="nav-link active" href="#">Home</a>
                    <a class="nav-link" href="#">Login</a>
                    </nav>
                </div>
            </div>

            <div class="inner cover">
                <h1 class="cover-heading">We make the news real</h1>
                <br><br>
                <p class="lead">Texter is the best social network to spread the news.</p>
                <p class="lead">
                    <a href="#" class="btn btn-lg btn-secondary">Join the Community</a>
                </p>
            </div>
        </div>

    </div>

</div>
<script src="<c:url value="resources/js/jquery-3.1.0.min.js"/> "></script>
<script>window.jQuery || document.write('<script src="resources/js/jquery.min.js"><\/script>')</script>
<script src="<c:url value="resources/js/bootstrap.min.js"/> "></script>
<script src="<c:url value="resources/js/tether.min.js"/> "></script>

</body>
</html>
