<%--suppress BadExpressionStatementJS --%>
<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 30.10.16
  Time: 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="user" type="model.User" scope="request"/>
<html>
<head>
    <title><%=user.getUsername()%></title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/registerPage.css'/>"/>
    <script>
        function handelAnswer(data) {
//            console.log(data);
            if(data === "true"){
//                console.log("true");
                document.getElementById("followButton").className = "btn btn-danger";
            } else {
//                console.log("false 2");
                document.getElementById("followButton").className = "btn btn-primary";
            }
        }

        var username = "${user.username}";
        function doStuff() {
            $.ajax({
                url: "/s/follow",
                type: "GET",
                data: {"username": username},
                success: function(result){
                    handelAnswer(result)
                }
            })
        }
        addEventListener ("DOMContentLoaded", doStuff, false)
    </script>
</head>
<body>
<p/>Hello, <%=user.getFirstName()%> <%=user.getLastName()%>

<a id="followButton" class="btn btn-primary" onclick="followClick('<%=user.getUsername()%>')">Follow</a>
</body>
<script>
    function followClick(data) {
//        console.log("clicked");
        $.ajax({
            url: "/s/follow",
            type: "POST",
            data: {'username':data},
            success: function(result){
//                console.log("result is "+result);
                handelAnswer(result);
            },
            error: function (e) {
                alert("Error!");
            }
        });
    }
</script>
</html>
