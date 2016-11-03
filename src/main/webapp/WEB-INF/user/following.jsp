<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 03.11.16
  Time: 20:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="model.Following" %>
<%@ page import="model.User" %>
<html>
<head>
    <title>Following</title>
</head>
<body>
<jsp:useBean id="user" type="model.User" scope="request"/>
<jsp:useBean id="followings" class="java.util.HashSet" scope="request"/>

User <%=user.getUsername()%> follows them:<br>
<% HashSet<User> followingUsers = (HashSet<User>) followings;%>
<% for(User u: followingUsers){%>
<br><%=u.getUsername()%>
<%}%>

</body>
</html>
