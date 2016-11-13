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
        var me = this;
        $.ajax({
            url: '/webapi/posts/',
            type: 'GET',
            data: {
                userId: this.userId,
                visitorId: this.visitorId,
                offsetId: 1000000000,
                limit: 10
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.post.text + "</strong> by " + view.user.username + "<br>";
                    var like = document.createElement("p");
                    like.innerHTML = "Likes: " + view.likesCount;
                    var comments = document.createElement("p");
                    comments.innerHTML = "Comments: " + view.commentsCount;
                    me.postContainer.appendChild(line);
                    me.postContainer.appendChild(like);
                    me.postContainer.appendChild(comments);
                    me.offsetId = view.post.id;
                });
                PostHandler.updateUserPosts(me.userId, me.visitorId, me.offsetId, 10, me.postContainer);
            }
        })
    }

    static updateUserPosts(userId, visitorId, offsetId, limit, postContainer) {
        console.log("update posts");
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
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.post.text + "</strong> by " + view.user.username + "<br>";
                    var like = document.createElement("p");
                    like.innerHTML = "Likes: " + view.likesCount;
                    var comments = document.createElement("p");
                    comments.innerHTML = "Comments: " + view.commentsCount;
                    postContainer.appendChild(line);
                    postContainer.appendChild(like);
                    postContainer.appendChild(comments);
                    offsetId = view.post.id;
                });
                PostHandler.updateUserPosts(userId, visitorId, offsetId, limit, postContainer);
            }
        })
    }
}

class Timeline{

    constructor(userId, postContainer){
        this.userId = userId;
        this.postContainer = postContainer;
    }

    loadTimeline(){
        var self = this;
        $.ajax({
            url: '/webapi/posts/timeline/',
            type: 'GET',
            data: {
                userId: this.userId,
                offsetId: 1000000000,
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
                    self.offsetId = view.post.id;
                })
            }
        })
    }
}
