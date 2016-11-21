/**
 * Created by wopqw on 06.11.16.
 */
class FollowThings {

    constructor(username, visitor){
        this.username = username;
        this.visitor = visitor;
    }

    static handleAnswer(data) {
        if (data === "true") {
            document.getElementById("followButton").className = "btn btn-danger";
        } else {
            document.getElementById("followButton").className = "btn btn-primary";
        }
    }


    doStuff() {
        console.log(this.username);
        console.log(this.visitor);
        if(this.username === this.visitor){
            document.getElementById("followButton").style.display = "none";
        } else {
            $.ajax({
                url: "/s/follow",
                type: "GET",
                data: {"username": this.username},
                success: function (result) {
                    FollowThings.handleAnswer(result)
                }
            })
        }
    }

    followClick(data) {
        $.ajax({
            url: "/s/follow",
            type: "POST",
            data: {'username': data},
            success: function (result) {
                FollowThings.handleAnswer(result);
            },
            error: function (e) {
                alert("Error!");
            }
        });
    }
}

class PostHandler {

    constructor(userId, visitorId, postContainer) {

        this.userId = userId;
        this.visitorId = visitorId;
        this.postContainer = postContainer;

    }

    loadUserPosts() {
        console.log("loading");
        console.log("visitorId = "+visitorId);
        var me = this;
        me.offsetId = 0;
        $.ajax({
            url: '/webapi/posts/',
            type: 'GET',
            data: {
                userId: this.userId,
                visitorId: this.visitorId,
                offsetId: me.offsetId,
                limit: 10
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    PostHandler.createContainers(view, me.postContainer, visitorId);
                    if(me.offsetId < view.post.id)
                            me.offsetId = view.post.id;
                });
                PostHandler.updateUserPosts(me.userId, me.visitorId, me.offsetId, 10, me.postContainer);
            }
        })
    }

    static updateUserPosts(userId, visitorId, offsetId, limit, postContainer) {
        console.log("offsetID: "+offsetId);
        $.ajax({
            url: '/webapi/posts/update',
            type: 'GET',
            data: {
                userId: userId,
                visitorId: visitorId,
                offsetId: offsetId,
                limit: limit
            },
            dataType: 'json',
            timeout: 11000,
            success: function (views) {
                views.forEach(function (view) {
                    PostHandler.createContainers(view, postContainer, visitorId);
                    if(offsetId < view.post.id)
                            offsetId = view.post.id;
                });
                PostHandler.updateUserPosts(userId, visitorId, offsetId, limit, postContainer);
            },
            error: function (err) {
                console.log(err);
                PostHandler.updateUserPosts(userId, visitorId, offsetId, limit, postContainer);
            }
        })
    }

    static createContainers(view, postContainer, visitorId) {
        var panel = document.createElement("div");
        panel.className = "panel panel-default";
        panel.id = view.post.id;
        var pHeading = document.createElement("div");
        pHeading.className = "panel-heading";
        var anchor = document.createElement("a");
        anchor.href = "/post/"+view.post.id;
        anchor.className = "pull-right";
        anchor.innerHTML = "Open post";
        var h4 = document.createElement("h4");
        h4.innerHTML = "<a href='/user/"+view.user.username+"'>@"+view.user.username+"</a>";
        // pHeading.innerHTML = "<h4>@" + view.user.username + "</h4>";
        pHeading.appendChild(anchor);
        pHeading.appendChild(h4);
        panel.appendChild(pHeading);
        var pBody = document.createElement("div");
        pBody.id = view.post.id;
        pBody.className = "panel-body";
        pBody.innerHTML = "<p/>"+view.post.text+"<hr>";
        var datetime = document.createElement("div");
        datetime.innerHTML = view.post.time+" "+view.post.time;
        datetime.style = "text-align: right";
        pBody.appendChild(datetime);
        var likes = document.createElement("button");
        // likes.onclick = "liker.makeLike("+'\''+view.post.id+'\''+")";
        $(pBody).on('click','button',function(){
            Like.makeLike(visitorId,view.post.id, likes);
        });
        var answ = PostHandler.isLiked(view.post.id, visitorId)
        answ.then(function (res) {
            if (res === true)
                likes.className = "btn btn-danger";
            else likes.className = "btn btn-default";

        });
        likes.innerHTML = "+"+view.likesCount;
        pBody.appendChild(likes);
        var comments = document.createElement("div");
        comments.style="float:right";
        comments.innerHTML = view.commentsCount+" comments";
        pBody.appendChild(comments);
        panel.appendChild(pBody);
        postContainer.insertBefore(panel, postContainer.firstChild);
    }

    static isLiked(postId, userId){
        console.log('function called');
        return new Promise(function (resolve, reject) {
            $.ajax({
                url: '/webapi/likes/isliked',
                type: 'GET',
                data: {
                    'userId': userId,
                    'postId': postId
                },
                success: function (answer) {
                    resolve(answer);
                },
            })
        });
    }
}

class Timeline{

    constructor(userId, postContainer){
        this.userId = userId;
        this.postContainer = postContainer;
    }

    loadTimeline(){
        var self = this;
        self.offsetId = 0;
        $.ajax({
            url: '/webapi/posts/timeline/',
            type: 'GET',
            data: {
                userId: this.userId,
                offsetId: self.offsetId,
                limit: 10
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    PostHandler.createContainers(view, self.postContainer, userId);
                    if(self.offsetId < view.post.id)
                        self.offsetId = view.post.id;
                });
                Timeline.updateTimeline(self.userId, self.offsetId, 10, self.postContainer);
            }
        })
    }
    static updateTimeline(userId, offsetId, limit, postContainer){
        console.log(offsetId);
        $.ajax({
            url: '/webapi/posts/updatetimeline',
            type: 'GET',
            data: {
                userId: userId,
                offsetId: offsetId,
                limit: limit
            },
            dataType: 'json',
            timeout: 11000,
            success: function (views) {
                views.forEach(function (view) {
                    PostHandler.createContainers(view, postContainer, userId);
                    if(offsetId < view.post.id)
                        offsetId = view.post.id;
                });
                Timeline.updateTimeline(userId, offsetId, limit, postContainer);
            },
            error: function (err) {
                console.log(err);
                Timeline.updateTimeline(userId, offsetId, limit, postContainer);
            }
        })
    }
}
class Like{
    static makeLike(visitorId, postId, container){
        console.log("like with "+postId+" and "+visitorId);
        if(this.visitorId === null)
            alert("auth");
        else{
            $.ajax({
                url: '/webapi/likes/isliked',
                type: 'GET',
                data: {
                    'userId': visitorId,
                    'postId': postId
                },
                success: function (answer) {
                    var url;
                    var color;
                    var me = this;
                    if (answer===true) {
                        url = '/webapi/likes/remove';
                        me.color = 'btn btn-default';
                    }
                    else {
                        url = '/webapi/likes/add';
                        me.color = 'btn btn-danger';
                    }
                    $.ajax({
                        url: url,
                        type: 'GET',
                        data: {
                            'userId': visitorId,
                            'postId': postId
                        },
                        success: function (likes) {
                            container.innerHTML = "+"+likes;
                            container.className = me.color
                        }
                    })
                }
            })
        }
    }
}

class CommentController{

    constructor(userId, postId, offsetId, container){
        console.log('commentController constructor with '+postId+' us '+userId );
        this.userId = userId;
        this.postId = postId;
        this.container = container;
        this.offsetId = offsetId;
        this.limit = 10;
        this.list = [];
    }

    loadComments(){
        console.log('loading comments');
        var me = this;
        return new Promise(function (resolve, reject) {
            $.ajax({
                url: '/webapi/comments/'+me.postId,
                type: 'GET',
                data: {
                    'offsetId': me.offsetId,
                    'limit': me.limit
                },
                success: function (comments) {
                    resolve(comments);
                }
            })
        })
    }

    viewComments() {
        console.log("postId: "+this.postId);
        var me = this;
        this.loadComments().then(function (res) {
            me.list = res;
            var chandler = document.createElement('ul');
            chandler.className = "commentList";
            console.log(me.list);
            me.list.forEach(function (l) {
                CommentController.createContainer(chandler, l);
                if (me.offsetId < l.id)
                    me.offsetId = l.id;
            });
            me.container.appendChild(chandler);
            CommentController.updateComments(me.postId, me.offsetId, me.limit, chandler, me.container);
        })
    }

    static createContainer(container, comment){
        console.log(comment);
        var li = document.createElement('li');
        li.id = comment.id;
        var imgHandler = document.createElement('div');
        imgHandler.className = 'commenterImage';
        var img = document.createElement('img');
        img.src = "../../resources/img/quest.gif";
        imgHandler.appendChild(img);
        li.appendChild(imgHandler);
        var texthandler = document.createElement('div');
        texthandler.className =  'commentText';
        var username = document.createElement('span');
        username.className = 'commenter-username';
        username.innerHTML = comment.userId;
        texthandler.appendChild(username);
        var text = document.createElement('p');
        text.innerHTML = comment.text;
        texthandler.appendChild(text);
        var datetime = document.createElement('span');
        datetime.className = 'date sub-text';
        datetime.innerHTML = comment.date+' '+comment.time;
        var del = document.createElement('button');
        del.className = "delete";
        del.innerHTML = 'delete';
        del.id = comment.id;
        // del.onclick = CommentController.deleteComment(del);
        // $(pBody).on('click','button',function(){
        //     Like.makeLike(visitorId,view.post.id, likes);
        // });
        $(texthandler).on('click','button', function () {
            CommentController.deleteComment(del)
        });
        texthandler.appendChild(datetime);
        texthandler.appendChild(del);
        li.appendChild(texthandler);
        container.appendChild(li);
    }

    static updateComments(postId, offsetId, limit, container1, container2){
        console.log('offsetId: '+offsetId);
        $.ajax({
            url:'/webapi/comments/update',
            type: 'GET',
            data:{
                'postId': postId,
                'offsetId': offsetId,
                'limit': limit
            },
            dataType: 'json',
            timeout: 11000,
            success: function (array) {
                array.forEach(function (l) {
                    CommentController.createContainer(container1, l);
                    if (offsetId < l.id)
                        offsetId = l.id;
                });
                container2.appendChild(container1);
                CommentController.updateComments(postId, offsetId, limit, container1, container2);
            },
            error: function (err) {
                console.log(err);
                CommentController.updateComments(postId, offsetId, limit, container1, container2);
            }
        })
    }

    static deleteComment(container){
        var id = container.id;
        console.log('delete comment: '+id);
        $.ajax({
            url: '/webapi/comments/delete/'+id,
            type: 'DELETE',
            success: function (answe) {
                window.location.reload();
            }
        })
    }
}
