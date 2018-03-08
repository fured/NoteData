# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

# Register your models here.
from fured.models import BookTable,CommentTable,PlayMusicTable,RecommendMusicTable,ShareMoiveTable

class PlayMusicTableAdmin(admin.ModelAdmin):
    readonly_fields = ('createdTime',)
    # 显示的列
    #fields = ('dateTime', 'id','content')
admin.site.register(PlayMusicTable,PlayMusicTableAdmin)
admin.site.register([BookTable,CommentTable,RecommendMusicTable,ShareMoiveTable])
