# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.contrib import admin

# Register your models here.
from fured.models import BookTable,CommentTable,PlayMusicTable,RecommendMusicTable,ShareMoiveTable
admin.site.register(BookTable)
admin.site.register([CommentTable,PlayMusicTable,RecommendMusicTable,ShareMoiveTable])
