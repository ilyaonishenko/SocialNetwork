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

class PostHandler{

    constructor(userId, visitorId, postContainer){

        this.userId = userId;
        this.visitorId = visitorId;
        this.postContainer = postContainer;

    }

    loadUserPosts(){
        var self = this;
        $.ajax({
            url: '/webapi/posts/',
            type: 'GET',
            data: {
                userId: this.userId,
                visitorId: this.visitorId,
                offsetId: 1000000000,
                limit: 1000
            },
            dataType: 'json',
            success: function(views) {
                views.forEach(function (view) {
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.text + " </strong>";
                    self.postContainer.appendChild(line);
                    self.offsetId = view.offsetId;
                })
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
            url: 'webapi/post/timeline',
            type: 'GET',
            data: {
                userId: this.userId,
                offsetId: 1000000000,
                limit: 1000
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    var line = document.createElement("p");
                    line.innerHTML = "<strong>" + view.text + " </strong>";
                    self.postContainer.appendChild(line);
                    self.offsetId = view.offsetId;
                })
            }
        })
    }
}