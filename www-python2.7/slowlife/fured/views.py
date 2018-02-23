# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import pdb,random,json,time
from django.shortcuts import render
from django.http import HttpResponse
from fured.models import PlayMusicTable,RecommendMusicTable,BookTable,ShareMoiveTable
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
    return render(request,'index.html',{"show_book":show_book,"show_movie":share_movie})

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
    recommend = RecommendMusicTable()
    recommend.song_name = data_py["songname"]
    recommend.song_type = data_py["type"]
    recommend.recommend_name = data_py["nickname"]
    recommend.recommend_reason = data_py["reason"]
    recommend.create_at = int(time.time())
    recommend.save()
    return HttpResponse("recommend success!thank you:"+data_py["nickname"]+"!")

