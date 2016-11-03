<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 03.11.16
  Time: 21:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.User" %>
<html>
<head>
    <title>Followers</title>
</head>
<body>
<jsp:useBean id="user" type="model.User" scope="request"/>
<jsp:useBean id="followers" class="java.util.HashSet" scope="request"/>

This is <%=user.getUsername()%>'s followers:<br>
<% HashSet<User> followerUsers = (HashSet<User>) followers;%>
<% for(User u: followerUsers){%>
<br><%=u.getUsername()%>
<%}%>

</body>
</html>
