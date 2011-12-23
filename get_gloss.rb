#!/usr/bin/ruby

fp = File.open("data.noun", "r");


data = fp.readlines;
data.each do |line|
next if line.nil?
words = line.split("|")
gloss_w_ex = words[1]
next if gloss_w_ex.nil?
gloss_words = gloss_w_ex.split(";")
gloss = gloss_words[0]
puts gloss
end
