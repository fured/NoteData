// JavaScript Document
var currentIndex = 0;
var mlist = ["http://qzone.haoduoge.com/music2/Meghan Trainor - All About That Bass.mp3","http://sc1.111ttt.com/2014/1/11/11/4111319506.mp3","http://qzone.haoduoge.com/music2/2014-12-13/1418401256.mp3","http://qzone.haoduoge.com/music2/2014-10-03/1412280314.mp3","http://qzone.haoduoge.com/music2/2014-11-29/1417258107.mp3"];
var audio = document.getElementById('audio');
var progress = document.getElementById('progress_music');
var playpause = document.getElementById("play-pause");
var volume = document.getElementById("volume");

audio.controls = false;

audio.addEventListener('timeupdate', function() {
  	updateProgress();
}, false);

function togglePlayPause() {
   if (audio.paused || audio.ended) {
      playpause.title = "暂停";
      playpause.className = "begin";
      audio.play();
   } else {
      playpause.title = "播放";
      playpause.className = "stop";
      audio.pause();
   }
}

function setVolume() {
   audio.volume = volume.value;
}

function updateProgress() {
	var percent = Math.floor((100 / audio.duration) * audio.currentTime);
	progress.value = percent;
	var canvas = document.getElementById('progress_music');
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
	if (audio.ended) resetPlayer();
}

function resetPlayer() {
	audio.currentTime = 0; context.clearRect(0,0,canvas.width,canvas.height);
	playpause.title = "Play";
}

//function sel(){
//	mlist.src = mlist[currentIndex];
//	audio.play();
//	}

window.onload=function(){ 
	slt();
//	num();
}

function slt(){
	var tBn=document.getElementsByClassName("lt");
	var div=document.getElementsByTagName("div");
	
	var i;
	for(i=0;i<tBn.length;i++){
		tBn[i].index=i;//为每个按钮都建立索引
		tBn[i].onclick=function(){//为每个按钮注册单击事件
		for(i=0;i<tBn.length;i++){
			tBn[i].setAttribute("class","lt");//js中凡是出现class的地方都用className代替
		}
		this.setAttribute("class","lt act");//this代表当前发生事件的元素
			currentIndex = (this.getAttribute("index"));
			audio.src = mlist[currentIndex];
			audio.play();
//			sel();
		};
	}
};

/*function num(){
    var n = document.getElementById("lt").getElementsByTagName("div")
        for(i=0;i<n.length;i++){
            n.item(i).onclick=function(){
                alert(this.getAttribute("index"));
                }
            }   
    }*/
