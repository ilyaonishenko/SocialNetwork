<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 31.10.16
  Time: 2:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.UserRole" %>
<jsp:useBean id="user" type="model.User" scope="request"/>
<jsp:useBean id="userRoles" class="java.util.HashSet" scope="request"/>
<html>
<head>
    <title>HomePage</title>
    <%--<% HashSet<User> roles = (HashSet<String>)session.getAttribute("ROLE");%>--%>
</head>
<body>
Welcome to your homePage, <%=user.getFirstName()%>!
<br>
Your role in this project: <br>
<% HashSet<UserRole> roles = (HashSet<UserRole>) userRoles;%>
<% for(UserRole role: roles){%>
<br><%=role%>
<%}%>
<p1>your posts:</p1>

</body>
</html>
