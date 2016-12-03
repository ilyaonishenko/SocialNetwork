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
<jsp:useBean id="throwable" scope="request" type="java.lang.String"/>
<jsp:useBean id="statusCode" scope="request" type="java.lang.Integer"/>
<jsp:useBean id="servletName" scope="request" type="java.lang.String"/>
<jsp:useBean id="requestUri" scope="request" type="java.lang.String"/>
<jsp:useBean id="errorMsg" scope="request" type="java.lang.String"/>
<html>
<head>
    <title>Error!</title>
    <%--<meta http-equiv="Refresh" content="2; URL=/login">--%>
</head>
<body>
<h3>We have an error!</h3>
<p>status code: ${statusCode}</p>
<p>the problem with uri: ${requestUri}</p>
<p>with servlet: ${servletName}</p>
<p>exception: ${throwable}</p>
<p>error message: ${errorMsg}</p>
</body>
</html>
