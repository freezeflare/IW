#!/usr/bin/env python
from nltk.stem.wordnet import WordNetLemmatizer
import sys

a = WordNetLemmatizer()

#while 1:
#try:
line = sys.stdin.readline()
#except line == KeyboardInterrupt:
#	break

#if not line:
#	break
	
nline = line.rstrip("\n")
#	if nline == 'NULL':
#		break	
	#print "this is nline " + nline
tup = nline.partition(" ")
	#print  tup
if tup[2] == 'v':
	ret = a.lemmatize(tup[0], 'v')
	print ret,
else:
	ret = a.lemmatize(nline)
	print ret,

