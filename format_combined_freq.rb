#!/usr/bin/ruby

require 'pp'

class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_freqs"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
		 fh = File.open(name)
		 ht = Marshal.load(fh)
		 @htable = add_to_table(ht)
		 File.open(name, "w") {|file| Marshal.dump(@htable, file)}
       #File.open(name) {|file| Marshal.load(name)}
     end
   end


	def build_table

		fp = File.open("/media/mynewdrive/lem.txt", "r");
		#sf = File.open("htable_stop_words")

		#stop_word = Marshal.load(sf)
		ar = Array.new(5)
		i = 0;
		h = Hash.new

		fp.each do |line|
			split_line = line.split
			key = split_line[0]+ split_line[1]



			while (i < 5)
				#str = fp.scanf("%s")[0]
				#str.gsub!(/[^0-9a-zA-z]/, "")
				#if (!stop_word[str].nil?)
				#	next
				#end
				
				ar[i] = key
				#puts str
				i+=1
				h[key].nil? ? h[key] = 1 : h[key] += 1
				next
			end 
		
			for j in (0 .. 3)
					#	puts ar[j]
					#	puts ar[j+1]
					co_occur = ar[j] + ar[4]
					h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
			end
			ar.delete_at(0)
			ar.push(key)
		end
		for j in (0 .. 3)
					#	puts ar[j]
					#	puts ar[j+1]
					co_occur = ar[j] + ar[4]
					h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
		end

		return h
	end

	def add_to_table(h)
		fp = File.open("/media/mynewdrive/lem_story.txt", "r");
		#sf = File.open("htable_stop_words")

		#stop_word = Marshal.load(sf)
		ar = Array.new(5)
		i = 0;
		#h = Hash.new

		fp.each do |line|
			split_line = line.split
			key = split_line[0]+ split_line[1]



			while (i < 5)
				#str = fp.scanf("%s")[0]
				#str.gsub!(/[^0-9a-zA-z]/, "")
				#if (!stop_word[str].nil?)
				#	next
				#end
				
				ar[i] = key
				#puts str
				i+=1
				h[key].nil? ? h[key] = 1 : h[key] += 1
				next
			end 
		
			for j in (0 .. 3)
					#	puts ar[j]
					#	puts ar[j+1]
					co_occur = ar[j] + ar[4]
					h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
			end
			ar.delete_at(0)
			ar.push(key)
		end
		for j in (0 .. 3)
					#	puts ar[j]
					#	puts ar[j+1]
					co_occur = ar[j] + ar[4]
					h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
		end

		return h
	end
end


#main
if __FILE__ == $0
   d = Dict.new
   pp d.htable
end
