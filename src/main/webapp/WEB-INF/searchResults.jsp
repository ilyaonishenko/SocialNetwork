<%@ page import="model.User" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 05.12.16
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="possibleUsers" class="java.util.ArrayList" scope="request"/>
<html>
<head>
    <title>SEARCH RESULTS</title>
</head>
<body>
<% ArrayList<User> users = (ArrayList<User>) possibleUsers;%>
<% for (User u: users){%>
<br><%=u%>
<%}%>
</body>
</html>
