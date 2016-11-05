/**
 * Created by wopqw on 06.11.16.
 */
class FollowThings {

    constructor(){
        this.username = "hello";
    }

    static handleAnswer(data) {
        //            console.log(data);
        if (data === "true") {
//                console.log("true");
            document.getElementById("followButton").className = "btn btn-danger";
        } else {
//                console.log("false 2");
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
//        console.log("clicked");
        $.ajax({
            url: "/s/follow",
            type: "POST",
            data: {'username': data},
            success: function (result) {
//                console.log("result is "+result);
                FollowThings.handleAnswer(result);
            },
            error: function (e) {
                alert("Error!");
            }
        });
    }
}