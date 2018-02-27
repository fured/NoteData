#!/usr/bin/python
# -*- coding: utf-8 -*-
from mutagen import File
import sys,MySQLdb,pdb
def mp3_parse(filename):
	audio = File(filename)
        print audio
        pdb.set_trace()
	title = audio.tags['TIT2'].text
	song_name = ''.join(title)
        print song_name
	with open('../images/music/'+song_name+'.jpg','wb') as img:
            try:
               img.write(audio.tags['APIC:'].data)
               song_image_path = "/static/images/music/"+song_name+'.jpg'
            except Exception as e:
                print "not image"
                #default play picture
                song_image_path = "/static/images/head.png"
        try:
            songer_name = audio.tags['TPE2'].text[0]
        except KeyError as e:
            try:
                songer_name = audio.tags['TPE1'].text[0]
            except Exception as e:
                print "not songer name"
                songer_name = "don't know"
        print songer_name
        print song_image_path
        storage_path = "/static/music/"+filename
        print storage_path
        db = MySQLdb.connect("localhost","root","fuli19960121","slowlife")
        cursor = db.cursor()
        sql = "insert into play_music_table(song_name,songer_name,song_image_path,storage_path)values('"+song_name+"','"+songer_name+"','"+song_image_path+"','"+storage_path+"')"
       # try:
        cursor.execute(sql)
        db.commit()
        #except:
         #   db.rollback()
        db.close()
if __name__ == "__main__":
	if len(sys.argv) < 2:
		print '[usage]parse_mp3.py mp3file'
		exit()
        reload(sys)
        sys.setdefaultencoding("utf-8")
	mp3_parse(sys.argv[1])
