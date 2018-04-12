# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import pdb,random,json,time
from django.shortcuts import render
from django.http import HttpResponse
from fured.models import PlayMusicTable,RecommendMusicTable,BookTable,ShareMoiveTable,CommentTable,UserTable,CommentMovieTable
# Create your views here.
def index(request):
    pdb.set_trace()
    print request.META["REMOTE_HOST"];
    book = BookTable.objects.all().values()
    show_book = []
    i = 0
    while i < len(book):
        show_book.append(book[i])
        i = i + 1
    movie = ShareMoiveTable.objects.all().values()
    share_movie = []
    j = 0
    while j < len(movie):
        share_movie.append(movie[j])
        j = j + 1
    song_list = []
    i = 0
    all_song_name = PlayMusicTable.objects.all().values('storage_path')
    while i < len(all_song_name):
        #if i == (len(all_song_name) - 1):
        song_list.append(all_song_name[i]["storage_path"])
       # else:
          #  song_list.append(all_song_name[i]["storage_path"]+":")
        i = i + 1
    #return render(request,'index.html',{"show_book":show_book,"show_movie":share_movie,"book_count":len(show_book),"moive_count":len(share_movie)})
    return render(request,'index.html',{"show_book":show_book,"show_movie":share_movie,"play_list":json.dumps(song_list)})

def view_test(request):
    return render(request,"view-test.html")

def modal(request):
    return render(request,"modal.html")

def register(request):
    data = request.body
    data_py = json.loads(data) 
    user = UserTable()
    user.user_name = data_py["name"]
    user.user_email = data_py["email"]
    user.user_password = data_py["password"]
    user.save()
    print data
    return HttpResponse("Register success!")

def login(request):
    data = request.body
    data_py = json.loads(data)
    name = data_py["name"]
    password = data_py["password"]
    user = UserTable.objects.filter(user_name=name)
    if len(user) < 1:
        return HttpResponse("name is not exist!")
    if user[0].user_password == password:
        return HttpResponse("welcome "+data_py["name"])

def reader(request):
    current_lang = request.GET.get("lang")
    if current_lang == "zh":
        current_lang  = current_lang+"-CN"
    return render(request,"demo.html",{"lang":current_lang})

def video_player(request):
    return render(request,"view-movie.html")


def vue_test(request):
    return render(request,"vue-test.html")

def recommend_music(request):
    current_lang = request.GET.get("lang")
    recommends = RecommendMusicTable.objects.all().values()
    recommends_list = []
    i = 0 
    while i < len(recommends):
        recommends_list.append(recommends[i])
        recommends_list[i]["create_at"] = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(recommends_list[i]["create_at"]))
        i = i + 1
    author_recommend = PlayMusicTable.objects.all().values()
    j = 0
   # print (type(author_recommend[j]["createdTime"]))
    while j < len(author_recommend):
        recommends_list.append(author_recommend[j])
       # recommends_list[len(recommends_list)-1]["create_at"] = time.strftime("%Y-%m-%d %H:%M:%S",time.localtime(int(time.time())))
        #print author_recommend[j]["create_at"]
        recommends_list[len(recommends_list)-1]["create_at"] = author_recommend[j]["createdTime"].strftime("%Y-%m-%d %H:%M:%S")
        recommends_list[len(recommends_list)-1]["recommend_name"] = "fured"
        recommends_list[len(recommends_list)-1]["recommend_reason"] = "fured favorite music"
        j = j + 1
    random.shuffle(recommends_list)
    return render(request,"recommend_music_table.html",{"list":recommends_list,"lang":current_lang})

	
def playlist(request):
	print "play list"
	song_list = []
	i = 0 
	all_song_name = PlayMusicTable.objects.all().values('storage_path')
	while i < len(all_song_name):
		song_list.append(all_song_name[i]["storage_path"])
		i = i + 1
    #random.shuffle(song_list)
	return HttpResponse(json.dumps(song_list))

def recommend(request):
	print "this"
	data = request.body
	data_py = json.loads(data)
	lang = data_py["lang"]
	recommend = RecommendMusicTable()
	recommend.song_name = data_py["songname"]
	recommend.song_type = data_py["type"]
	recommend.recommend_name = data_py["nickname"]
	recommend.recommend_reason = data_py["reason"]
	recommend.create_at = int(time.time())
	recommend.save()
	if lang == "zh":
		reponse = "分享成功！谢谢"+data_py["nickname"]+"!"
	else:
		reponse = "recommend success!thank you:"+data_py["nickname"]+"!"
	print reponse
	return HttpResponse(reponse)

def movie_comment_submit(request):
    data = request.body
    data_py = json.loads(data)
    comment = CommentMovieTable()
    comment.user_name = data_py["user_name"]
    comment.content = data_py["content"]
    comment.user_address = data_py["address"]
    comment.user_img_path = "/static/img.jpg"
    comment.save()
    return HttpResponse("success!")

def movie_comment_init(request):
    comments = CommentMovieTable.objects.all().values()
    comments_list = []
    i = 0
    while i < len(comments):
        comments_list.append(comments[i])
        i = i+1
    return HttpResponse(json.dumps(comments_list))

def message(request):
    data = request.body
    data_py = json.loads(data)
    lang = data_py["lang"]
    message = CommentTable()
    message.comment_name = data_py["user_name"]
    message.comment_email = data_py["your_email"]
    message.comment_message = data_py["user_message"]
    message.create_at = int(time.time())
    message.save()
    if lang == "zh":
        reponse = "留言已经被fured得知！谢谢"+data_py["user_name"]+"!"
    else:
        reponse ="leave meaaage success!thank you:"+data_py["user_name"]+"!"
    return HttpResponse(reponse)

def transform_language(request):
    current_lang = request.GET.get("lang")
    if current_lang == "en":
        with open("./fured/static/language/zh.json","r") as fd:
            lang_str = fd.read()
            data = "zh"
    else:
        with open("./fured/static/language/en.json","r") as fd:
            lang_str = fd.read()
            data = "en"
    lang_data_py = json.dumps(json.loads(lang_str))
    reponse = '{"slogin":"'+data+'","language_data":'+lang_data_py+'}'
    return HttpResponse(reponse)

def view_recommend_lang(request):
    current_lang = request.GET.get("lang")
    if current_lang == "zh":
        with open("./fured/static/language/recommend_zh.json","r") as fd:
            lang_str = fd.read()
    else:
        with open("./fured/static/language/recommend_en.json","r") as fd:
            lang_str = fd.read()
    lang_data_py =json.dumps(json.loads(lang_str)) 
    reponse = '{"language_data":'+lang_data_py+'}'
    return HttpResponse(reponse)
