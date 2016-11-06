/**
 * Created by wopqw on 06.11.16.
 */
class FollowThings {

    constructor(){
        this.username = "hello";
    }

    static handleAnswer(data) {
        if (data === "true") {
            document.getElementById("followButton").className = "btn btn-danger";
        } else {
            document.getElementById("followButton").className = "btn btn-primary";
        }
    }


    doStuff() {
        $.ajax({
            url: "/s/follow",
            type: "GET",
            data: {"username": this.username},
            success: function (result) {
                FollowThings.handleAnswer(result)
            }
        })
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
                offsetId: 0,
                limit: 10
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

    // addView(view) {
    //     this.postContainer.appendChild(view);
    //     this.offsetId = view.id;
    // }
    
    
}

// $.ajax({
//     url: "/restapi/posts/",
//     data: {
//         userId: sessionUser.id,
//         fromId: user.id,
//         offsetId: offsetId,
//         limit: 10
//     },
//     type: "GET",
//     dataType: "json",
//     success: function (postViews) {
//         postViews.forEach(function (postView) {
//             postsContainer.appendChild(addPostView(postView));
//             offsetId = postView.postId;
//         });
//
//         // no more posts
//         if (postViews.length == 0) {
//             $(window).off('scroll');
//         } else {
//             $(window).off('scroll').scroll(function () {
//                 if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
//                     loadUserPosts(user, offsetId);
//                 }
//             });
//         }
//     }
// });
// }