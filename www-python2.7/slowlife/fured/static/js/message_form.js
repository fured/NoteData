var message_form = document.getElementById('leave_message');
function confirm_message(){
	var user_name = message_form["user_name"].value;
	if (user_name == ""){
		if (lang == "zh"){
			alert("名字不允许为空！");
			return;
		}else{
			alert("name is not allowed to be empty!");
			return;
		}
	}
	var your_email = message_form["your_email"].value;
	if (your_email == ""){
		if (lang == "zh"){
			alert("邮箱不允许为空！");
			return;
		}else{
			alert("email is not allowed to be empty!");
			return;
		}
	}else{
		var re = /^[a-z0-9\.\-\_]+\@[a-z0-9\-\_]+(\.[a-z0-9\-\_]+){1,4}$/;
		if ( ! re.test(your_email.trim().toLowerCase())){
			if (lang == "zh"){
				alert("请输入正确的邮箱地址！");
				return;
			}else{
				alert("please input correct email address!");
				return;
			}
		}
	}

	var user_message = document.getElementById("user_message").value;
	console.log(user_message);
	if (user_message == ""){
		if (lang == "zh"){
			alert("留言怎么可以不写？");
			return;
		}else{
			alert("message is not allowed to be empty!");
			return;
		}
	}
	var url = "../message/submit";
	var request = new XMLHttpRequest();
	request.onload = function(){
		if ( request.status == 200){
			alert(request.responseText);
		}
	};
	var data = '{"user_name":"'+user_name+'","your_email":"'+your_email+'","user_message":"'+user_message+'","lang":"'+lang+'"}';
	request.open("POST",url,true);
	request.setRequestHeader("Content-Type","application/x-www-form-urlencoded;");
	request.send(data);
}
