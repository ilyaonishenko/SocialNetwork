<%--suppress ELValidationInJSP --%>
<%--
  Created by IntelliJ IDEA.
  User: wopqw
  Date: 20.11.16
  Time: 3:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="postView" type="model.PostView" scope="request"/>
<html>
<head>
    <title>Post</title>
    <script type="text/javascript" src="<c:url value='../../resources/js/jquery-3.1.0.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value="../../resources/js/userScript.js"/>"></script>
    <link rel="stylesheet" href="<c:url value='../../resources/css/bootstrap.min.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/styles.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/navbar.css'/>"/>
    <link rel="stylesheet" href="<c:url value='../../resources/css/post.css'/>"/>
</head>
<body>
<div class="wrapper">
    <div class="box">
        <div class="row row-offcanvas row-offcanvas-left">
            <div class="column col-sm-10 col-xs-11" style="width:100%" id="main">
                <c:choose>
                    <c:when test="${not (empty sUser)}">
                        <jsp:include page="../common/logged_navbar.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <jsp:include page="../common/loggedOut_navbar.jsp"/>
                    </c:otherwise>
                </c:choose>
                <div class="padding">
                    <div class="full col-sm-9">
                        <div class="row">
                            <%--right--%>
                            <div class="col-sm-7">
                                <div class="panel panel-default" id="${postView.post.id}">
                                    <div class="panel panel-heading">
                                        <h4>
                                            <a href='/user/${postView.user.username}'>@${postView.user.username}</a>
                                        </h4>
                                        <span class="date sub-text">${postView.post.time} ${postView.post.date}</span>
                                    </div>
                                    <div class="panel panel-body" id="${postView.post.id}">
                                        <p/>${postView.post.text}
                                        <hr>
                                        <form>
                                            <div class="input-group">
                                                <div class="input-group-btn" id="$${postView.post.id}">
                                                    <button id="likes" class="btn btn-default"
                                                            onclick="Like.makeLike('${sUser.id}','${postView.post.id}', document.getElementById('$${postView.post.id}'))">
                                                        +${postView.likesCount}</button>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="actionBox">
                                        <div id="comments">

                                        </div>
                                        <form class="form-inline" name="myForm" id="commentForm" action="/post/${postView.post.id}">
                                            <div class="form-group">
                                                <input class="form-control" name="text" type="text" placeholder="Your comment"/>
                                            </div>
                                            <div class="form-group">
                                                <button class="btn btn-default" onclick="addComment(this.form)">Add</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function checkLikes() {
        var likes = document.getElementById('likes');
        PostHandler.isLiked('${postView.post.id}','${sUser.id}').then(function (res) {
            if (res === true)
                likes.className = "btn btn-danger";
            else likes.className = "btn btn-default";
    })}
    function startComment() {
        var cController = new CommentController('${sUser.id}','${postView.post.id}', 0, document.getElementById('comments'));
        cController.viewComments();
    }
    function addComment(form) {
        console.log('sending from sendComment');
        var text = form.text.value;
        console.log('text: '+text);
        $.ajax({
            url: '/webapi/comments/add',
            type: 'GET',
            data:{
                'userId':'${sUser.id}',
                'postId':'${postView.post.id}',
                'text': text
            }
        })
    }
    addEventListener ("DOMContentLoaded",checkLikes, false);
    addEventListener ("DOMContentLoaded",startComment, false);
</script>
</html>
