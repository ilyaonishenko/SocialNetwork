<%@ page import="model.Post" %>
<%@ page import="model.User" %>
<%@ page import="model.Comment" %>
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
<jsp:useBean id="possiblePosts" class="java.util.ArrayList" scope="request"/>
<jsp:useBean id="possibleComments" class="java.util.ArrayList" scope="request"/>
<html>
<head>
    <title>SEARCH RESULTS</title>
</head>
<body>
<h5>USERS</h5>
<% ArrayList<User> users = (ArrayList<User>) possibleUsers;%>
<% for (User u: users){%>
<br><%=u%>
<%}%>
<hr>
<h5>POSTS</h5>
<% ArrayList<Post> posts = (ArrayList<Post>) possiblePosts;%>
<% for (Post p: posts){%>
<br><%=p%>
<%}%>
<hr>
<h5>COMMENTS</h5>
<% ArrayList<Comment> comments = (ArrayList<Comment>) possibleComments;%>
<% for (Comment c: comments){%>
<br> <%=c%>
<%}%>
</body>
</html>
