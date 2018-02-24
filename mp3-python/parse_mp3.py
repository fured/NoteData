# -*- coding: utf-8 -*-
from mutagen import File
import sys
def mp3_parse(filename):
	audio = File(filename)
	title = audio.tags['TIT2'].text
	song_name = ''.join(title)
	with open(song_name+'.jpg','wb') as img:
		img.write(audio.tags['APIC:'].data)
	
if __name__ == "__main__":
	if len(sys.argv) < 2:
		print '[usage]parse_mp3.py mp3file'
		exit()
	mp3_parse(sys.argv[1])