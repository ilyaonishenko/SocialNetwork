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
        anchor.href = "#";
        anchor.className = "pull-right";
        anchor.innerHTML = "Open post";
        var h4 = document.createElement("h4");
        h4.innerHTML = "@"+view.user.username;
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
        likes.className = "btn btn-default";
        likes.innerHTML = "+"+view.likesCount;
        pBody.appendChild(likes);
        var comments = document.createElement("div");
        comments.style="float:right";
        comments.innerHTML = view.commentsCount+" comments";
        pBody.appendChild(comments);
        panel.appendChild(pBody);
        postContainer.insertBefore(panel, postContainer.firstChild);
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
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.post.text + "</strong> by "+view.user.username+"<br>";
                    var like = document.createElement("p");
                    like.innerHTML = "Likes: "+view.likesCount;
                    var comments = document.createElement("p");
                    comments.innerHTML = "Comments: "+view.commentsCount;
                    self.postContainer.appendChild(line);
                    self.postContainer.appendChild(like);
                    self.postContainer.appendChild(comments);
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
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.post.text + "</strong> by "+view.user.username+"<br>";
                    var like = document.createElement("p");
                    like.innerHTML = "Likes: "+view.likesCount;
                    var comments = document.createElement("p");
                    comments.innerHTML = "Comments: "+view.commentsCount;
                    var postView = document.createElement('div');
                    postView.appendChild(line);
                    postView.appendChild(like);
                    postView.appendChild(comments);
                    postContainer.insertBefore(postView, postContainer.firstChild);
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
                    if (answer===true)
                        url = '/webapi/likes/remove';
                    else url = '/webapi/likes/add';
                    $.ajax({
                        url: url,
                        type: 'GET',
                        data: {
                            'userId': visitorId,
                            'postId': postId
                        },
                        success: function (likes) {
                            container.innerHTML = "+"+likes;
                        }
                    })
                }
            })
        }
    }
}
