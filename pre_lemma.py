#!/usr/bin/env python
from nltk.stem.wordnet import WordNetLemmatizer
import sys
#import os
#import nltk

#path = "/media/mynewdrive/new_txt"
#dirList = os.listdir(path)

path = "/media/mynewdrive/pos_story.txt"

f = open(path, "r")

a = WordNetLemmatizer()

for line in f:
	nline = line.rstrip()
	sep = nline.partition(" ")
	if sep[2] == "VERB":
		print a.lemmatize(sep[0], 'v') + " " + sep[2]
	elif sep[2] == "NOUN":
		print a.lemmatize(sep[0]) + " " + sep[2]
 	elif sep[2] == "ADJ":
		print a.lemmatize(sep[0], 'a') + " " + sep[2]
	elif sep[2] == "ADV":
		print a.lemmatize(sep[0], 'r') + " " + sep[2]





#while 1:
#try:

#except line == KeyboardInterrupt:
#	break

#if not line:
#	break
	
#nline = line.rstrip("\n")
#	if nline == 'NULL':
#		break	
	#print "this is nline " + nline
#tup = nline.partition(" ")
	#print  tup
#if tup[2] == 'v':
#	ret = a.lemmatize(tup[0], 'v')
#	print ret,
#else:
#	ret = a.lemmatize(nline)
#	print ret,

