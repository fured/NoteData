function change_language(){
	var url = "../language/transform";
	var request = new XMLHttpRequest();
	request.onload = function(){
		if (request.status == 200){
			transform(request.responseText)
			console.log("language transform success ");
		}
	};
	request.open("GET",url+'/?lang='+lang,true);
	request.send();
}

function transform(json_str){
	var language = JSON.parse(json_str);
	console.log(language["language_data"]["web_theme"])
	document.getElementById("web_theme").innerHTML = language["language_data"]["web_theme"]
	document.getElementById("web_label").innerHTML = language["language_data"]["web_label"]
	document.getElementById("section_one_name").innerHTML = language["language_data"]["section"]["one_name"]
	document.getElementById("section_two_name").innerHTML = language["language_data"]["section"]["two_name"]
	document.getElementById("section_three_name").innerHTML = language["language_data"]["section"]["three_name"]
	document.getElementById("section_four_name").innerHTML = language["language_data"]["section"]["four_name"]
	document.getElementById("section_five_name").innerHTML = language["language_data"]["section"]["five_name"]
	document.getElementById("music_title").innerHTML = language["language_data"]["Music"]["title"]
	document.getElementById("music_recommend_saying").innerHTML = language["language_data"]["Music"]["recommend"]["saying"]
	document.getElementById("music_recommend_theme").innerHTML = language["language_data"]["Music"]["recommend"]["theme"]
	document.getElementById("music_recommend_slogan").innerHTML = language["language_data"]["Music"]["recommend"]["solgan"]
	document.getElementById("music_recommend_form_title").innerHTML = language["language_data"]["Music"]["recommend_form"]["title"]
	document.getElementById("music_recommend_form_title2").innerHTML = language["language_data"]["Music"]["recommend_form"]["title2"]
	document.getElementById("music_recommend_form_nick_name").innerHTML = language["language_data"]["Music"]["recommend_form"]["nick_name"]
	document.getElementById("music_recommend_form_song_name").innerHTML = language["language_data"]["Music"]["recommend_form"]["song_name"]
	document.getElementById("music_recommend_form_reason").innerHTML = language["language_data"]["Music"]["recommend_form"]["reason"]
	document.getElementById("music_recommend_form_type").innerHTML = language["language_data"]["Music"]["recommend_form"]["type"]
	document.getElementById("music_recommend_form_select_default").innerHTML = language["language_data"]["Music"]["recommend_form"]["select"]["default"]
	document.getElementById("music_recommend_form_select_one").innerHTML = language["language_data"]["Music"]["recommend_form"]["select"]["one"]
	document.getElementById("music_recommend_form_select_two").innerHTML = language["language_data"]["Music"]["recommend_form"]["select"]["two"]
	document.getElementById("music_recommend_form_select_three").innerHTML = language["language_data"]["Music"]["recommend_form"]["select"]["three"]
	document.getElementById("music_recommend_form_default_one").placeholder = language["language_data"]["Music"]["recommend_form"]["default"]["one"]
	document.getElementById("music_recommend_form_default_two").placeholder = language["language_data"]["Music"]["recommend_form"]["default"]["two"]
	document.getElementById("music_recommend_form_default_three").placeholder = language["language_data"]["Music"]["recommend_form"]["default"]["three"]
	document.getElementById("music_recommend_form_submit").value = language["language_data"]["Music"]["recommend_form"]["submit"]
	document.getElementById("music_music_player_slogan").innerHTML = language["language_data"]["Music"]["music_player"]["slogan"]
	document.getElementById("music_music_player_date").innerHTML = language["language_data"]["Music"]["music_player"]["date"]
	document.getElementById("book_bar_title").innerHTML = language["language_data"]["book_bar"]["title"]
	console.log(book_count);
	//document.getElementById("book_bar_download_button").innerHTML = language["language_data"]["book_bar"]["download_button"]
	document.getElementById("moive_title").innerHTML = language["language_data"]["moive"]["title"]
	document.getElementById("moive_download_button").innerHTML = language["language_data"]["moive"]["download_button"]
	document.getElementById("leave_message_title").innerHTML = language["language_data"]["leave_message"]["title"]
	document.getElementById("leave_message_author_information_title").innerHTML = language["language_data"]["leave_message"]["author_information"]["title"]
	document.getElementById("leave_message_author_information_description").innerHTML = language["language_data"]["leave_message"]["author_information"]["description"]
	document.getElementById("leave_message_author_information_more").innerHTML = language["language_data"]["leave_message"]["author_information"]["more"]
	document.getElementById("leave_message_author_information_address").innerHTML = language["language_data"]["leave_message"]["author_information"]["address"]
	document.getElementById("leave_message_message_form_title").innerHTML = language["language_data"]["leave_message"]["message_form"]["title"]
	document.getElementById("leave_message_message_form_one_default").placeholder = language["language_data"]["leave_message"]["message_form"]["one_default"] 
	document.getElementById("leave_message_message_form_two_default").placeholder = language["language_data"]["leave_message"]["message_form"]["two_default"] 
	document.getElementById("leave_message_message_form_three_default").placeholder = language["language_data"]["leave_message"]["message_form"]["three_default"] 
	document.getElementById("leave_message_message_form_submit").innerHTML = language["language_data"]["leave_message"]["message_form"]["submit"] 
	document.getElementById("bottom_language").innerHTML = language["language_data"]["bottom"]["language"]
	document.getElementById("bottom_admin_login").innerHTML = language["language_data"]["bottom"]["admin_login"]
	lang = language["slogin"]
	console.log(lang)
}
