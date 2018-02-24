//confirm music recommend form 
var myform = document.getElementById('recommend_form');
//var myform = document.forms["recommend_form"];

function confirm_recommend_form(){
	var nickname = myform["name"].value;
	console.log(nickname);
	if (nickname == "") {
		if (lang == "zh"){
			alert("给您起一个好听的昵称");
			return;
		}else{
			alert("Nickname is not allowed to be empty!");
			return;
		}
	}
	var songname = myform["song_name"].value;
	if (songname == "") {
		if (lang == "zh"){
			alert("歌名不应该不写呀！");
			return;
		}else{
			alert("Song name is not allowed to be empty!");
			return;
		}
	}
	var reason = myform["reason"].value;
	if (reason == "") {
		if (lang == "zh"){
			alert("总有喜欢的理由吧？随便写点。");
			return;
		}else{
			alert("Reason is not allowed to be empty!");
			return;
		}
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

	request.open("POST",url,true);
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
	request.send(data)
}
