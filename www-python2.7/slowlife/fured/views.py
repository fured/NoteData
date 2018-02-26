# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import pdb,random,json,time
from django.shortcuts import render
from django.http import HttpResponse
from fured.models import PlayMusicTable,RecommendMusicTable,BookTable,ShareMoiveTable,CommentTable
# Create your views here.
def index(request):
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
    test = "123"
    return render(request,'index.html',{"show_book":show_book,"show_movie":share_movie,"test":test})

def playlist(request):
    song_list = []
    i = 0 
    all_song_name = PlayMusicTable.objects.all().values('song_name')
    while i < len(all_song_name):
        song_list.append('/static/music/' + all_song_name[i]['song_name'] + ':')
        i = i + 1
    random.shuffle(song_list)
    return HttpResponse(song_list)

def recommend(request):
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
    return HttpResponse(reponse)

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

