# -*- coding: utf-8 -*-
from __future__ import unicode_literals
import pdb,random
from django.shortcuts import render
from django.http import HttpResponse
from fured.models import PlayMusicTable
# Create your views here.
def index(request):
    aa = PlayMusicTable.objects.all()
    song_name = aa.values('song_name')[0]['song_name']
    return render(request,'index.html',{'test':song_name})

def playlist(request):
    song_list = []
    i = 0 
    all_song_name = PlayMusicTable.objects.all().values('song_name')
    while i < len(all_song_name):
        song_list.append('/static/music/' + all_song_name[i]['song_name'] + ':')
        i = i + 1
    random.shuffle(song_list)
    return HttpResponse(song_list)

