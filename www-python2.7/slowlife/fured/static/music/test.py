# -*- coding: utf-8 -*- 
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
with open("我不愿让你一个人.mp3","rb") as fd:
    print fd.read().decode("utf-8")

test = b"我不"
print test
print sys.getdefaultencoding();
