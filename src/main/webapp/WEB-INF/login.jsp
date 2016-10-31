<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 19:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<form method="POST" action="/login">
    <input name="j_username" title="Login"/><br/>
    <input type="password" name="j_password" autocomplete="off" title="Password"/><br/>
    <input type="submit" value="submit"/>
</form>
</body>
</html>
