// JavaScript Document
var currentIndex = 0;
//var mlist = ["/static/music/BeginAgain.mp3","/static/music/Red.mp3","/static/music/StayStayStay.mp3","/static/music/Starlight.mp3"];
var mlist = [];
var change_play = false;
var audio = document.getElementById('audio');
var progress = document.getElementById('progress');
var playpause = document.getElementById("play-pause");
var volume = document.getElementById("volume");
var music_menu = document.getElementById('music_menu');
var song_name = document.getElementById('song_name');

audio.controls = false;

audio.addEventListener('timeupdate', function() {
  	updateProgress();
}, false);
audio.addEventListener('ended',function(){
	slt();
	audio_play();
},false);

function togglePlayPause() {
   if (audio.paused || audio.ended) {
      playpause.title = "暂停";
      playpause.className = "begin";
	  music_menu.className = "start";
      audio_play();
   } else {
      playpause.title = "播放";
      playpause.className = "stop";
	  music_menu.className = "menu";
      audio_pause();
   }
}

function audio_play(){
	audio.play();
	song_name.className = "animate";
	song_name.innerHTML = mlist[currentIndex - 1].slice(14).split(".")[0]
}
function audio_pause(){
	audio.pause()
	song_name.className = "noanimate"
}
function play_previous(){
	audio.pause();
	  song_name.className = "noanimate";
	change_play = true;
	updateProgress();
	change_play = false;
	currentIndex = currentIndex - 2;
	if (currentIndex == -1){
		currentIndex = mlist.length - 2;
	}
	console.log(currentIndex)
	audio.src = mlist[currentIndex]
	currentIndex = currentIndex + 1;
	audio_play()
}

function play_next(){
	audio.pause();
	  song_name.className = "noanimate";
	change_play = true;
	updateProgress();
	change_play = false;
	if (currentIndex == mlist.length - 1){
		currentIndex = 0
	}
	console.log(currentIndex)
	audio.src = mlist[currentIndex]
	currentIndex = currentIndex + 1;
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
		console.log("run this");
	    playpause.title = "Play";
	}
}

function resetPlayer() {
	audio.currentTime = 0; c
	ontext.clearRect(0,0,canvas.width,canvas.height);
	playpause.title = "Play";
}

//function sel(){
//	mlist.src = mlist[currentIndex];
//	audio.play();
//	}

window.onload=function(){ 
	var url = "../music_player/play_list"
	var request = new XMLHttpRequest();
	request.onload = function () {
		if (request.status == 200){
			//alert("success!")
			//console.log("success!")
			mlist = request.responseText.split(":");
			slt();
		}
	};
	request.open("GET",url)
	request.send(null)
//	num();
}

function slt(){
	if (currentIndex >= mlist.length) {
		currentIndex = 0
	}
	if (currentIndex == mlist.length - 1){
		currentIndex = 0;
	}
	audio.src = mlist[currentIndex];
	currentIndex = currentIndex + 1;
//	if (currentIndex >= mlist.length) {
//		currentIndex = 0;
//	}
};

/*function num(){
    var n = document.getElementById("lt").getElementsByTagName("div")
        for(i=0;i<n.length;i++){
            n.item(i).onclick=function(){
                alert(this.getAttribute("index"));
                }
            }   
    }*/
