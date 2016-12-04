/**
 * Created by wopqw on 06.11.16.
 */
class FollowThings {

    constructor(username, visitor = null){
        console.log(username);
        this.username = username;
        this.visitor = visitor;
    }

    static handleAnswer(data, username) {
        console.log("handle answeerr "+data);
        if (data === "true") {
            document.getElementById("followButton"+username).className = "btn btn-danger";
        } else {
            document.getElementById("followButton"+username).className = "btn btn-primary";
        }
    }


    doStuff() {
        console.log(this.username);
        console.log("visitor: "+this.visitor);
        console.log("len: "+this.visitor.length);
        let me = this;
        if(this.username === this.visitor || this.username == null || this.visitor.length===0){
            document.getElementById("followButton"+me.username).style.display = "none";
        } else {
            $.ajax({
                url: "/s/follow",
                type: "GET",
                data: {"username": this.username},
                success: function (result) {
                    FollowThings.handleAnswer(result, me.username)
                }
            })
        }
    }

    static doStuff(username, visitor) {
        if(username === visitor){
            document.getElementById("followButton"+username).style.display = "none";
        } else {
            $.ajax({
                url: "/s/follow",
                type: "GET",
                data: {"username": username},
                success: function (result) {
                    FollowThings.handleAnswer(result, username)
                }
            })
        }
    }

    followClick(data) {
        FollowThings.followClick(data);
    }

    static followClick(data) {
        $.ajax({
            url: "/s/follow",
            type: "POST",
            data: {'username': data},
            success: function (result) {
                FollowThings.handleAnswer(result, data);
            },
            error: function (e) {
                alert("Error!");
            }
        });
    }
}

class PostHandler {

    constructor(userId, visitorId = 0, postContainer) {

        this.userId = userId;
        this.visitorId = visitorId;
        this.postContainer = postContainer;
        this.firstOffset = 0;
    }

    loadUserPosts() {
        console.log("loading");
        console.log("visitorId = "+visitorId);
        let me = this;
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
                let count = 0;
                views.forEach(function (view) {
                    count += 1;
                    console.log(view);
                    PostHandler.createContainers(view, me.postContainer, visitorId);
                    if(me.offsetId < view.post.id)
                            me.offsetId = view.post.id;
                    me.firstOffset = me.offsetId-10;
                });
                console.log('count: '+count);
                if(count >=10) {
                    document.getElementById('buttonMore').style.display = "block";
                }
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
                // PostHandler.updateUserPosts(userId, visitorId, offsetId, limit, postContainer);
            },
            error: function (err) {
                console.log(err);
                console.log("error");
                PostHandler.updateUserPosts(userId, visitorId, offsetId, limit, postContainer);
            }
        })
    }

    loadPrevPosts(){
        console.log("loading prev posts");
        let me = this;
        me.firstOffset = firstOffset-10;
        $.ajax({
            url: '/webapi/posts/',
            type: 'GET',
            data: {
                userId: this.userId,
                visitorId: this.visitorId,
                offsetId: me.firstOffset,
                limit: 10
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    console.log(view);
                    PostHandler.createContainers(view, me.postContainer, visitorId, false);
                });
            }
        })
    }

    static createContainers(view, postContainer, visitorId, forward = true) {
        let panel = document.createElement("div");
        panel.className = "panel panel-default";
        if (view.post.authorId == visitorId){
            console.log("delete pretty ready");
            let form = document.createElement('form');
            form.method = 'post';
            form.action = '/webapi/posts/delete/'+view.post.id;
            form.className = 'pull-right';
            let anchor2 = document.createElement("button");
            anchor2.value = "submit";
            anchor2.type = "submit";
            anchor2.className ='class="btn btn-link"';
            anchor2.innerHTML = '<i class="glyphicon glyphicon-remove"></i>';
            $(form).on('click','button',function(){
                console.log("sending");
                setTimeout(function(){
                    window.location.reload(true);
                },100);
            });
            form.appendChild(anchor2);
            panel.appendChild(form);
        }
        panel.id = view.post.id;
        let pHeading = document.createElement("div");
        pHeading.className = "panel-heading";
        let anchor = document.createElement("a");
        anchor.href = "/post/"+view.post.id;
        anchor.style = "margin-top: 5px";
        anchor.className = "pull-right";
        anchor.innerHTML = "Open post";
        console.log("authorId: "+view.post.authorId);
        let h4 = document.createElement("h4");
        h4.innerHTML = "<a href='/user/"+view.user.username+"'>@"+view.user.username+"</a>";
        // pHeading.innerHTML = "<h4>@" + view.user.username + "</h4>";
        pHeading.appendChild(anchor);
        pHeading.appendChild(h4);
        panel.appendChild(pHeading);
        let pBody = document.createElement("div");
        pBody.id = view.post.id;
        pBody.className = "panel-body";
        pBody.innerHTML = "<p/>"+view.post.text+"<hr>";
        let datetime = document.createElement("div");
        datetime.innerHTML = TimeParser.parseTime(view.post.time)+"<br>"+TimeParser.parseDate(view.post.date);
        datetime.style = "text-align: right";
        pBody.appendChild(datetime);
        let likes = document.createElement("button");
        // likes.onclick = "liker.makeLike("+'\''+view.post.id+'\''+")";
        $(pBody).on('click','button',function(){
            Like.makeLike(visitorId,view.post.id, likes);
        });
        let answ = PostHandler.isLiked(view.post.id, visitorId);
        answ.then(function (res) {
            if (res === true)
                likes.className = "btn btn-danger";
            else likes.className = "btn btn-default";

        });
        likes.innerHTML = "+"+view.likesCount;
        pBody.appendChild(likes);
        let comments = document.createElement("div");
        comments.style="float:right";
        comments.innerHTML = view.commentsCount+" comments";
        pBody.appendChild(comments);
        panel.appendChild(pBody);
        if (forward === true) {
            console.log('forward is true');
            postContainer.insertBefore(panel, postContainer.firstChild);
        }
        else {
            console.log('forward is not true');
            postContainer.appendChild(panel);
        }
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

    constructor(userId, postContainer, isAdmin){
        this.userId = userId;
        this.postContainer = postContainer;
        this.isAdmin = isAdmin;
    }

    loadTimeline(){
        let self = this;
        self.offsetId = 0;
        $.ajax({
            url: '/webapi/posts/timeline/',
            type: 'GET',
            data: {
                userId: userId,
                offsetId: offsetId,
                limit: 10
            },
            dataType: 'json',
            success: function (views) {
                views.forEach(function (view) {
                    if (isAdmin == true) {
                        console.log("is admin");
                        PostHandler.createContainers(view, postContainer, view.post.authorId);
                    } else {
                        PostHandler.createContainers(view, postContainer, userId);
                    }
                    if(offsetId < view.post.id)
                        offsetId = view.post.id;
                });
                Timeline.updateTimeline(userId, offsetId, 10, postContainer, isAdmin);
            }
        })
    }
    static updateTimeline(userId, offsetId, limit, postContainer, isAdmin){
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
                    if (isAdmin == true) {
                        console.log("is admin");
                        PostHandler.createContainers(view, postContainer, view.post.authorId);
                    } else {
                        PostHandler.createContainers(view, postContainer, userId);
                    }
                    //noinspection JSUnresolvedVariable
                    if(offsetId < view.post.id)
                        { //noinspection JSUnresolvedVariable
                            offsetId = view.post.id;
                        }
                });
                Timeline.updateTimeline(userId, offsetId, limit, postContainer, isAdmin);
            },
            error: function (err) {
                console.log(err);
                Timeline.updateTimeline(userId, offsetId, limit, postContainer, isAdmin);
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
                    let url;
                    let me = this;
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

    constructor(userId, postId, offsetId, container, userRoles){
        console.log('commentController constructor with '+postId+' us '+userId );
        this.userId = userId;
        this.postId = postId;
        this.container = container;
        this.offsetId = offsetId;
        this.limit = 10;
        this.list = [];
        console.log(userRoles);
        // this.userRoles = JSON.parse(userRoles);
        this.userRoles = JSON.parse(JSON.stringify(userRoles || null ));
        console.log(this.userRoles);
    }

    loadComments(){
        console.log('loading comments');
        let me = this;
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
        let me = this;
        this.loadComments().then(function (res) {
            me.list = res;
            let chandler = document.createElement('ul');
            chandler.className = "commentList";
            console.log(me.list);
            me.list.forEach(function (l) {
                CommentController.createContainer(chandler, l, me.userId, me.userRoles);
                if (me.offsetId < l.id)
                    me.offsetId = l.id;
            });
            me.container.appendChild(chandler);
            CommentController.updateComments(me.postId, me.offsetId, me.limit, chandler, me.container, me.userId, me.userRoles);
        })
    }

    static createContainer(container, comment, userId, userRoles){
        console.log(comment);
        let li = document.createElement('li');
        li.id = comment.id;
        let imgHandler = document.createElement('div');
        imgHandler.className = 'commenterImage';
        let img = document.createElement('img');
        img.src = "../../resources/img/quest.gif";
        imgHandler.appendChild(img);
        li.appendChild(imgHandler);
        let texthandler = document.createElement('div');
        texthandler.className =  'commentText';
        let username = document.createElement('span');
        username.className = 'commenter-username';
        username.innerHTML = comment.username;  //qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq
        texthandler.appendChild(username);
        let text = document.createElement('p');
        text.innerHTML = comment.text;
        texthandler.appendChild(text);
        let datetime = document.createElement('span');
        datetime.className = 'date sub-text';
        datetime.innerHTML = TimeParser.parseDate(comment.date)+' '+TimeParser.parseTime(comment.time);
        // if (view.post.authorId == visitorId){
        //     console.log("delete pretty ready");
        //     let form = document.createElement('form');
        //     form.method = 'post';
        //     form.action = '/webapi/posts/delete/'+view.post.id;
        //     form.className = 'pull-right';
        //     let anchor2 = document.createElement("button");
        //     anchor2.value = "submit";
        //     anchor2.type = "submit";
        //     anchor2.className ='class="btn btn-link"';
        //     anchor2.innerHTML = '<i class="glyphicon glyphicon-remove"></i>';
        //     $(form).on('click','button',function(){
        //         console.log("sending");
        //         setTimeout(function(){
        //             window.location.reload(true);
        //         },100);
        //     });
        //     form.appendChild(anchor2);
        //     pBody.appendChild(form);
        // }

        // del.onclick = CommentController.deleteComment(del);
        // $(pBody).on('click','button',function(){
        //     Like.makeLike(visitorId,view.post.id, likes);
        // });
        texthandler.appendChild(datetime);
        if(comment.userId == userId || userRoles.length > 1){
            let del = document.createElement('button');
            del.className = "delete";
            del.innerHTML = '<i class="glyphicon glyphicon-remove"></i>';
            del.id = comment.id;
            texthandler.appendChild(del);
            $(texthandler).on('click','button', function () {
                CommentController.deleteComment(del);
                setTimeout(function(){
                    window.location.reload(true);
                },100);
            });
        }
        li.appendChild(texthandler);
        container.appendChild(li);
    }

    static updateComments(postId, offsetId, limit, container1, container2, userId, userRoles){
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
                    CommentController.createContainer(container1, l, userId, userRoles);
                    if (offsetId < l.id)
                        offsetId = l.id;
                });
                container2.appendChild(container1);
                CommentController.updateComments(postId, offsetId, limit, container1, container2, userId, userRoles);
            },
            error: function (err) {
                console.log(err);
                CommentController.updateComments(postId, offsetId, limit, container1, container2, userId, userRoles);
            }
        })
    }

    static deleteComment(container){
        let id = container.id;
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
class TimeParser{

    static parseDate(date){
        let newDate = "";
        newDate += date.dayOfMonth+" ";
        newDate += date.month+" ";
        newDate += date.year;

        return newDate;
    }

    static parseTime(time){
        let h = "";
        let m = '';
        let s = '';
        if ((''+time.hour).length===1) {
            h = '0' + time.hour;
        } else h = time.hour;
        h+=':';
        if ((''+time.minute).length===1) {
            m = '0' + time.minute;
        } else m = time.minute;
        m +=':';
        if ((''+time.second).length===1) {
            s = '0' + time.second;
        } else s = time.second;
        console.log(h+m+s);
        return h+m+s;
    }
}
