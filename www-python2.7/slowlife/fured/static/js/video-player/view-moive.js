/**
 * Created by Administrator on 2017/4/28.
 */

function setCookie(name,value,expiredays){
	var exdate = new Date;
	exdate.setDate(exdate.getDate()+expiredays)
	document.cookie = name+"="+escape(value)+((expiredays==null)?"":";expires="+exdate.toGMTString())
}

function getCookie(name){
	if (document.cookie.length > 0){
		start=document.cookie.indexOf(name + "=")
		if (start!=-1){ 
			start=start + name.length+1 
			end=document.cookie.indexOf(";",start)
			if (end==-1) end=document.cookie.length
			return unescape(document.cookie.substring(start,end))
		 } 
	 }
	return false
}

function submit_comment(){
	console.log("submit comment to server!")
	var url ="/movie_comment/submit/"
	var request =new XMLHttpRequest();
	request.onload = function(){
		if (request.status == 200){
			alert ("success!")
		}
	}
	var content = document.getElementById('content').value;
	console.log(content)
	var user_name = getCookie("user_name");
	if (user_name == false){
		alert("please login for release comment!")
		return 
	}
	var address = "default"
	var data =' {"user_name":"'+user_name+'","address":"'+address+'","content":"'+content+'"}';
	request.open("POST",url,true)
	request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded;");
	request.send(data)
}

'user strict';

window.onload = function () {

    //初始化
    var video = $('#video1').videoCt({
        title: '动画',              //标题
        volume: 0.2,                //音量
        barrage: true,              //弹幕开关
        comment: true,              //弹幕
        reversal: true,             //镜像翻转
        playSpeed: true,            //播放速度
        update: true,               //下载
        autoplay: false,            //自动播放
        clarity: {
            type: ['360P','480P'],            //清晰度
            src: ['http://www.w3school.com.cn/example/html5/mov_bbb.mp4',
                  'http://www.w3school.com.cn/example/html5/mov_bbb.mp4']      //链接地址
        },
        commentFile: '/static/js/video-player/comment.json'           //导入弹幕json数据
    });

    //扩展
    video.title;                    //标题
    video.status;                   //状态
    video.currentTime;              //当前时长
    video.duration;                 //总时长
    video.volume;                   //音量
    video.clarityType;              //清晰度
    video.claritySrc;               //链接地址
    video.fullScreen;               //全屏
    video.reversal;                 //镜像翻转
    video.playSpeed;                //播放速度
    video.cutover;                  //切换下个视频是否自动播放
    video.commentTitle;             //弹幕标题
    video.commentId;                //弹幕id
    video.commentClass;             //弹幕类型
    video.commentSwitch;            //弹幕是否打开
    $('#video1').bind('ended', function() {
        console.log('弹幕json数据：\n'+ video.comment());              //获取弹幕json数据
    });
}  
