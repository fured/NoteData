//confirm music recommend form 
var myform = document.getElementById('recommend_form');
//var myform = document.forms["recommend_form"];

function confirm_recommend_form(){
	var nickname = myform["name"].value;
	console.log(nickname);
	if (nickname == "") {
		alert("Nickname is not allowed to be empty!");
		return;
	}
	var songname = myform["song_name"].value;
	if (songname == "") {
		alert("Song name is not allowed to be empty!");
		return;
	}
	var reason = myform["reason"].value;
	if (reason == "") {
		alert("Reason is not allowed to be empty!");
		return;
	}
	var type = myform["music_type"].value;
    var url = "../music_recommend/submit";
	var request = new XMLHttpRequest();
	request.onload = function () {
		if (request.status == 200){
			alert(request.responseText);
		}
	};
	var data = '{"nickname":"'+nickname+'","songname":"'+songname+'","reason":"'+reason+'","type":"'+type+'"}';

	request.open("POST",url);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
	request.send(data)
}
