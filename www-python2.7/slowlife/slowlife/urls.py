"""slowlife URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.11/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url
from django.contrib import admin
from fured import views as fured_views
from django.contrib.staticfiles.urls import staticfiles_urlpatterns

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^$',fured_views.index),
    url(r'^view/recommend_music/',fured_views.recommend_music),
    url(r'^music_player/play_list',fured_views.playlist),
    url(r'^music_recommend/submit',fured_views.recommend),
    url(r'^message/submit',fured_views.message),
    url(r'^language/transform/$',fured_views.transform_language),
]
urlpatterns += staticfiles_urlpatterns()
