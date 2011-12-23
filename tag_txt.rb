#!/usr/bin/ruby
require 'rubygems'
require 'rbtagger'
require 'pp'

class Dict
   attr_accessor :htable
   def initialize
     name = "./tagged_test"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
       File.open(name) {|file| Marshal.load(name)}
     end
   end


def build_table

fp = File.open("corpus.txt", "r");

sf = File.open("htable_stop_words")
pf = File.open("htable_punc_tag")

stop_word = Marshal.load(sf)
punc = Marshal.load(pf)

data = fp.readlines;
h = Hash.new(0)
data.each do |line|
next if line.nil?
line 

tagger = Brill::Tagger.new 
tagged_words = tagger.tag(line)
for i in (0..tagged_words.length)
	if (tagged_words[i] == nil)
		next
	end
	tagged_words[i].first.downcase!
	puts "should be downcased!"
	puts tagged_words[i].first
	if (!stop_word[tagged_words[i].first].nil?
		 tagged_words[i].first == "" || 
		 tagged_words[i].first == nil || 
		 tagged_words[i].last == nil)
			puts "crap"
			puts tagged_words[i]
			next
	else
		if (punc[tagged_words[i].last].nil?)
			puts "punc"
			puts tagged_words[i]
			next
		else
			puts "real"
			tagged_words[i].first.gsub!(/[^0-9a-zA-z]/, "")
			puts tagged_words[i]
			key = tagged_words[i].first + tagged_words[i].last
			h[key] += 1;
		end
	end
end
end

end
end



#main
if __FILE__ == $0
  d = Dict.new
  pp d.htable
end

