function download_music(id){
	var recommend_table = document.getElementById("recommend_table");
	console.log("start download");
	//console.log(id.parentElement.rowIndex);
	//console.log(id.cellIndex+1);
	//console.log(recommend_table.rows[id.parentElement.rowIndex].cells[0].innerHTML);
	var song_name=recommend_table.rows[id.parentElement.rowIndex].cells[0].innerHTML;
	//song is or not download select form download_music_table
	//
	//window.location.href="/static/music/aa.mp3";
	
	}