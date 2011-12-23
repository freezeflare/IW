#!/usr/bin/ruby

require 'scanf.rb'

class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_combined_freq"
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

		stop_word = Marshal.load(sf)
		ar = Array.new(5)
		i = 0;
		h = Hash.new

		while (i < 5)
			str = fp.scanf("%s")[0]
			str.gsub!(/[^0-9a-zA-z]/, "")
			if (!stop_word[str].nil?)
				next
			end
			ar[i] = str.downcase
			puts str
			i+=1
		end 

		i = 0
		while (i < 5)
			j = i + 1
			while (j < 5)
				co_occur = ar[i] + ar[j]
				h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
				j += 1
			end
			i += 1
		end

		while (str = fp.scanf("%s")[0])
			str.gsub!(/[^0-9a-zA-z]/, "")
			if (!stop_word[str].nil?)
				next
			end
			ar.delete_at 0	
			ar.push(str.downcase)
			i = 0
			while (i < 4)
				co_occur = ar[i] + ar[4]
				h[co_occur].nil? ? h[co_occur] = 1 : h[co_occur]+=1
				i += 1
			end
		end
		return h
	end
end


#main
if __FILE__ == $0
   d = Dict.new
   puts d.htable
end
