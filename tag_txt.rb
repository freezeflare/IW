#!/usr/bin/ruby
require 'rubygems'
require 'rbtagger'
require 'pp'
require 'stemmer'

class String 
	include Stemmable 
end

class Dict
   attr_accessor :htable
   def initialize
=begin
		name = "./tagged_corpus"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
       File.open(name) {|file| Marshal.load(name)}
     end
=end
	build_table
   end


def build_table

dir_name = "/media/mynewdrive/story"
#dir_name = "./test"
#h = Hash.new
sf = File.open("htable_stop_words")
pf = File.open("htable_punc_tag")

stop_word = Marshal.load(sf)
punc = Marshal.load(pf)

count = 1
Dir.foreach(dir_name) do |file|
	if (file == '.' || file == '..')
		next
	end


fp = File.open(dir_name+"/"+file, "r");
if (File.directory?(fp))
	next
end

#puts "current file is " + file
#puts count 
#puts "out of 245"

#count += 1
#fp = File.open("corpus.txt")


#data = fp.readlines;
#puts data

#ar = Array.new(5)
#count = 0
#data.each do |line|
#next if line.nil?


fp.each do |line|
	
	if (/\S/ !~ line)
		#line = fp.readline
		next
	end

	#puts "line is " + line
	
	tagger = Brill::Tagger.new 
	tagged_words = tagger.tag(line)
	if (tagged_words == [])
		#puts "in here"
		next
	end
	for i in (0..tagged_words.length)
		if (tagged_words[i] == nil)
			next
		end
		tagged_words[i].first.downcase!
		#puts "in for loop"
		#puts "should be downcased!"
		#	puts tagged_words[i].first
		if (!stop_word[tagged_words[i].first].nil?)
			#	puts "stop words"
			#	puts tagged_words[i]
			next
		elsif ( tagged_words[i].first == "" || 
				 tagged_words[i].first == nil || 
				 tagged_words[i].last == nil)
			#	puts "crap"
			#	puts tagged_words[i]
			next
		else
			if (punc[tagged_words[i].last].nil?)
			#		puts "punc"
			#		puts tagged_words[i]
			next
		else
			tagged_words[i].first.gsub!(/[^0-9a-zA-z]/, "")
			tagged_words[i].last.gsub!(/[^0-9a-zA-z]/, "")
			if (tagged_words[i].first == "")
				next
			end
			if (tagged_words[i].first != "")
				#puts "current word is"
				#puts tagged_words[i].first
				case tagged_words[i].last
				when "NN", "NNS", "NNP", "NNPS"
=begin
					IO.popen("python lemma.py", "r+") do |pipe|
						pipe.write tagged_words[i].first
						pipe.close_write
						test = pipe.read
						test = test.strip
						pipe.close
						tagged_words[i] = [test, "NOUN"]
					end
=end
               puts tagged_words[i].first + " NOUN"
				when "VB", "VBD", "VBG", "VBN", "VBP", "VBZ"
=begin
					IO.popen("python lemma.py", "r+") do |pipe|
						input = tagged_words[i].first + " v"
						pipe.write input
						pipe.close_write
						test = pipe.read
						test = test.strip
						pipe.close
						tagged_words[i] = [test, "VERB"]
					end
=end
					puts tagged_words[i].first + " VERB"
				when "JJ", "JJR", "JJS"
					#puts "adj"
					#tagged_words[i] = [tagged_words[i].first, "ADJ"]
					puts tagged_words[i].first + " ADJ"
				when "RB", "RBR", "RBS"
					#puts "adv"
					#tagged_words[i] = [tagged_words[i].first, "ADV"]
					puts tagged_words[i].first + " ADV"
				else
					#puts "crap"
					next
				end
			end
=begin			
			key = tagged_words[i].first + tagged_words[i].last
			h[key].nil? ? h[key] = 1 : h[key] += 1
			if (count < 5)
				#puts "still populating"
				#puts key
				ar[count] = key
				count += 1
			else
				for j in (0 .. 3)
				#	puts ar[j]
				#	puts ar[j+1]
					co_occur = ar[j] + ar[j+1]
					h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
				end
				ar.delete_at 0
				ar.push(key)
			end
=end
		end
	end
end
end
#for j in (0 .. 3)
		#puts ar[j] 
		#puts ar[j+1]
#		co_occur = ar[j] + ar[j+1]
#		h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
#	end
end
#return h
end
end



#main
if __FILE__ == $0
  d = Dict.new
  #pp d.htable
  #build_table
end

