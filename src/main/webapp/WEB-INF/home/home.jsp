<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 31.10.16
  Time: 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="user" type="model.User" scope="request"/>
<html>
<head>
    <title>HomePage</title>
</head>
<body>
Welcome to your homePage, <%=user.getFirstName()%>!
</body>
</html>
