<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<html>
<head>
    <title>YO!</title>
</head>
<jsp:useBean id="user" type="model.User" scope="request"/>
<body>
<p/>Hello, <%=user.getFirstName()%> <%=user.getLastName()%>
</body>
</html>
