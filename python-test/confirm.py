#!/usr/bin/python
# -*- coding: UTF-8 -*-
# Instruction:The script is used for verification register form!
# Item:name and password
# condition:1.	"name" can't contain special characters;
#				"name" can't contain abuse characters;
#				0 < "name" length < 10 .
#			2.	10 < "password" length < 20;
#				"password" must contain number,capital letter,lower case letter,special characters;

import sys
import re
class confirm_register:
	def __init__(self,name,password):
		self.name = name
		self.password = password

	def confirm_name(self):
		if len(self.name) > 10 or len(self.name) < 1:
			self.error("Name's length less than 1 or more than 10!")		
		
		patt_special_char = re.compile(r'[^A-Z0-9a-z\u4e00-\u9fa5]')
		print patt_special_char.findall("self.name")
		if len(patt_special_char.findall(self.name)) != 0:
			self.error("Name can't contain special character!") 

	# confirm password
	def confirm_pass(self):
		# verification length
		if len(self.password) > 20 or len(self.password) < 10:
			self.error("Password's length less than 10 or more than 20!")
		
		# verification number
		patt_number = re.compile(r'[0-9]')
		if len(patt_number.findall(self.password)) == 0:
			self.error("Password must contain number 0-9!")

		# verification lower case letter
		patt_lower_letter = re.compile(r'[a-z]')
		if len(patt_lower_letter.findall(self.password)) == 0:
			self.error("Password must contain lower case letter!")

		# verification capital letter
		patt_capital_letter = re.compile(r'[A-Z]')
		if len(patt_capital_letter.findall(self.password)) == 0:
			self.error("Password must contain capital letter!")

		# verification special characters
		patt_special_char = re.compile(r'[^0-9A-Za-z]')
		print self.password
		print patt_special_char.findall(self.password)
		if len(patt_special_char.findall(self.password)) == 0:
			self.error("Password must contain special characters!")

	def error(self,reason):
		print reason
		exit()

def confirm_usage():
	if len(sys.argv) != 5:
		usage_error()
	if sys.argv[1] != "-name":
		usage_error()
	if sys.argv[3] != "-pass":
		usage_error()

def usage_error():
	print "please use right usage:\n 	[Usage] confirm.py -name 'your name' -pass 'your password'"
	exit()

if __name__ == "__main__":
	confirm_usage()
	test = "sdhj@sdkj$8"
	register = confirm_register(sys.argv[2],sys.argv[4])
	register.confirm_name()
	register.confirm_pass()
	print "Password setting success!"

