// JavaScript Document

var currentIndex = 0;
var play_history = [];
var mlist = [];
var change_play = false;
var audio = document.getElementById('audio');
var progress = document.getElementById('progress');
var playpause = document.getElementById("play-pause");
var volume = document.getElementById("volume");
var music_menu = document.getElementById('music_menu');
var song_name = document.getElementById('song_name');
var song_img = document.getElementById('music_music_player_song_img');

audio.controls = false;

audio.addEventListener('timeupdate', function() {
  	updateProgress();
}, false);
audio.addEventListener('ended',function(){
//	slt();
	play_next();
	console.log("bbbbbbbb")

},false);



function togglePlayPause() {

   if (audio.paused) {

      playpause.title = "暂停";

      playpause.className = "begin";

	  music_menu.className = "start";
      //console.log("pause")
	  song_img.className = "play-rotate"
      audio.play();
   }else if (audio.ended){
	   playpause.title = "暂停";
	   playpause.className = "begin";
	   music_menu.className = "start";
	   play_next();
	   console.log("next")
   } else {

      playpause.title = "播放";

      playpause.className = "stop";

	  music_menu.className = "menu";

      audio_pause();

   }

}

function image_error(){

	console.log("image load error!")

	song_img.src = "/static/images/head.png"

}

function audio_play(){

	//audio.play();
	song_name.className = "animate";
	song_img.src = "/static/images/music/"+mlist[currentIndex].slice(14).split(".")[0]+".jpg"
	song_img.className = "play-rotate"
	song_name.innerHTML = mlist[currentIndex].slice(14).split(".")[0]
	console.log("current play:"+currentIndex)
	audio.play();
}

function audio_pause(){
	audio.pause()
	song_name.className = "noanimate";

	song_img.className = "";

}

function play_previous(){

	audio.pause();
	song_name.className = "noanimate";
	change_play = true;
	updateProgress();
	change_play = false;
    if (play_history.length < 2 ){
		if (play_history.length == 1){
			play_history.pop();
			play_next();
		}else{
			play_next();
		}
	}else {
		play_history.pop();
		currentIndex = play_history[play_history.length - 1];
	}
	console.log(currentIndex)
    console.log(play_history)
	audio.src = mlist[currentIndex]
	audio_play()

}



function play_next(){
	audio.pause();
	song_name.className = "noanimate";
	change_play = true;
	updateProgress();
	change_play = false;
    currentIndex = Math.floor(Math.random()*mlist.length);
	play_history.push(currentIndex)
	console.log(play_history)
	audio.src = mlist[currentIndex]
//	currentIndex = currentIndex + 1;
	audio_play()

}



function setVolume() {

   audio.volume = volume.value;

}



function updateProgress() {
	var percent = Math.floor((100 / audio.duration) * audio.currentTime);
	progress.value = percent;
	var canvas = document.getElementById('progress');
	var context = canvas.getContext('2d');
	var centerX = canvas.width / 2;
	var centerY = canvas.height / 2;
	var radius = 100;
	var circ = Math.PI * 2;
	var quart = Math.PI / 2;
	var cpercent = percent / 100; /* current percent */
	context.beginPath();
	context.arc(centerX, centerY, radius, 0, ((circ) * cpercent), false);
	context.lineWidth = 5;
	context.strokeStyle = '#38ffb8';
	context.stroke();
	if (audio.ended || change_play ){
    	audio.currentTime = 0;
		context.clearRect(0,0,canvas.width,canvas.height);
	    playpause.title = "Play";
	}
}

function resetPlayer() {
	audio.currentTime = 0; c
	ontext.clearRect(0,0,canvas.width,canvas.height);
	playpause.title = "Play";
}

window.onload=function(){ 
	var url = "../music_player/play_list"
	var request = new XMLHttpRequest();
	request.onload = function () {
		if (request.status == 200){
			mlist = request.responseText.split(":");
			console.log(mlist);
			slt();
		}
	};
	request.open("GET",url,true);
	request.send(null)
}

function slt(){
	if (currentIndex >= mlist.length) {
		currentIndex = 0
	}
	if (currentIndex == mlist.length - 1){
		currentIndex = 0;
	}
	currentIndex = Math.floor(Math.random()*mlist.length)
	audio.src = mlist[currentIndex];
	play_history.push(currentIndex);
	song_name.className = "animate";
	song_img.src = "/static/images/music/"+mlist[currentIndex].slice(14).split(".")[0]+".jpg"
	song_name.innerHTML = mlist[currentIndex].slice(14).split(".")[0]
	console.log("current play:"+currentIndex)

//	currentIndex = currentIndex + 1;
};
