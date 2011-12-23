#!/usr/bin/ruby

fp = File.open("data.noun", "r");


data = fp.readlines;
data.each do |line|
next if line.nil?
words_w_stuff = line.split
words = words_w_stuff[4]
sense = words_w_stuff[5]
puts words
puts sense
end
