#!/usr/bin/ruby
require 'pp'

class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_xml"
     #if !File.exists? name
       @htable = build_table
       File.open(name, "w+") {|file| Marshal.dump(@htable, file)}
     #else
     #  File.open(name) {|file| Marshal.load(file)}
     #end
   #endh = Hash.new
	end


def build_table
dir_name = "./merged"
sw = File.open("./htable_stop_words", "r");

stop_list = Marshal.load(sw)
h = Hash.new
gloss_to_sensekey = Hash.new

#un_tagged = Hash.new
#name = "/media/mynewdrive/untagged_list"
name = "./untagged_list"
uf = File.open(name, "w+")
#puts "here"
Dir.foreach(dir_name) do |file|
	#puts file
	fp = File.open(dir_name+"/"+file, "r");
	next if File.directory?(fp)


	#fp = File.open("./newtestxml.xml", "r");
	#fp = File.open("./Leon-IW/smalladv.xml", "r");

	syn = FALSE
	defin = FALSE
	arr = Array.new
	#term = ""
	#mult_temrs = FALSE
	keys = Array.new
	un_tag = Array.new
	glose_done = FALSE
	gloss = ""

	fp.each do |line|
		next if line.nil?
		words = line.split(" ")

		test_line = line.split(">")
		if (test_line[0] == "<sk")
			puts line
		end
		#puts words[0]
	
		#start of synset
		if (words[0] == "<synset")
			#puts "yes?"
			syn = TRUE
			arr = Array.new
			keys = Array.new
			un_tag = Array.new
			gloss = ""
			gloss_done = FALSE
			next
		end
		
		#test_line = line.gsub(/\s+/,"")
		#if (test_line =~ /<sk>cold%1:26:00::/)
	#			puts line 	
	#			puts "WTF?"
	#	end

		if (syn && words[0] == "<keys>")
			#puts words[0]
			nline = fp.readline
			nline.gsub!(/\s+/, "")
			puts nline
			fir_spl = nline.split(">")
			while (fir_spl[0] != "<sk")
				nline = fp.readline
				nline.gsub!(/\s+/, "")
				fir_spl = nline.split(">")
				#fir_spl[0].gsub!(/\s+/, "")
			end
			while (TRUE)
				#adds to the keys for this entry
				#nline.gsub!(/\s+/,"")
			#	if (nline =~ /<sk>cold/)
		#			puts nline 	
	#				puts "WTF?"
	#			end
				#fir_spl = nline.split(">")
				#fir_spl[0].gsub!(/\s+/, "")
								#pp fir_spl
				if (fir_spl[0] == "<sk")
					puts nline
					sec_spl = fir_spl[1].split(">")
					thr_spl = sec_spl[0].split("<")
					keys.push(thr_spl[0])
					nline = fp.readline
					nline.gsub!(/\s+/, "")
					fir_spl = nline.split(">")
				else
					break
				end
			end
			line = nline
			words = line.split(" ")
		end
		
		#check for original
		if (!gloss_done)
		 	orig = line.split(">")
			orig_tag = orig[0].gsub!(/\s+/, "")
			if (orig_tag == "<orig")
				#puts "YES"
				#puts "orig"
				#pp orig 
				inter_gloss = orig[1].split(";")[0]
				#puts "inter_gloss"
				#pp inter_gloss
				test_gloss = inter_gloss.split("<")
				gloss = test_gloss[0]
				#puts gloss
				gloss_done = TRUE
			end
		end

		#puts words[4]
		#puts words[0] == "</synset>"
	
		#puts "the whole line is"
		#puts line
		
		case words[0]
		when "<def"
			defin = TRUE
		when "<wf"

			#puts "in wf"
			if (defin && syn)
				spl = words[words.length() -1].split(">")
				#pp spl
				case spl[0]
				when "tag=\"ignore\"", "type=\"punc\"", "type=\"punc\""
					#ignored
					next
				when "tag=\"un\""
					#add to untagged list
					#term_spl = spl[1].split("<")
					#pp words
					index = -1
					lem_index = -1
					for i in (0..words.length() -1)
						if (words[i] =~ /pos=*/)
							index = i
							if (lem_index != -1)
								break
							end
						end
						if (words[i] =~ /lemma=*/)
							lem_index = i
							if (index != -1)
								break
							end
						end
					end
					#puts "current line"
					#puts line
					pre_word = words[lem_index].split("=")[1]
					next if pre_word == ""
					pre_word.gsub!("\"","")
				   #puts "pre word"
					#pp pre_word
					word_with_per = pre_word.split("|")[0]
					next if word_with_per.nil?
					#pp word_with_per
					word = word_with_per.split("%")[0]
					pos_spl = words[index].split("=")[1]
					pos_spl.gsub!("\"","")
					pos = ""
					case pos_spl
					when "NN", "NNS", "NNP", "NNPS"
						pos = "noun"
					when "VB", "VBD", "VBG", "VBN", "VBP", "VBZ"
						pos = "verb"
					when "JJ", "JJR", "JJS"
						pos = "adj"
					when "RB", "RBR", "RBS"
						pos = "adv"
					end
					#pp term_spl
					#may not need this
					if (!stop_list[word].nil?)
						next
					end
					#puts term_spl[0]
					#un_tagged.push(term_spl[0])
					#may not need this
					ht = Hash.new
					#term = term_spl[0] + " " + pos
					word = word + " " + pos
					ht[word] = "untagged_words"
					#puts line
					#puts word
					arr.push(ht)
					un_tag.push(word)
				when "tag=\"man\"","tag=\"auto\""
					ht = Hash.new
					#get word
					term_spl = words[2].split("=")
					quot_spl = term_spl[1].split("\"")
					term = quot_spl[1]
					#pp quot_spl
					#need to format quot_spl, currently with |
					#read the next line for id
					nline = fp.readline
					test_line = nline.split(">")
					if (test_line[0] == "<sk")
						puts nline
					end

					#puts nline
					fir_split = nline.split(" ")
					#puts "fir_splt"
					#pp fir_split
					start = -1
					for i in (1..fir_split.length() -1)
						if (spl[i] =~ /sk=*/)
								start = i
							break
						end
					end
						
					id_split = fir_split[start].split("=")
					#puts "id_split"
					#pp id_split
					id_woq = id_split[1].split("\"")
					id = id_woq[1]
					term_t = id.split(":")[0]
					#pp id
						#get word paired with tagged ID
					ht[term_t] = id 
					arr.push(ht)
				else
					next
				end
			else
				next
			end
		when "<cf"
			#puts "in cf"
			next if words[5].nil?
			tag = words[5].split(">")[0]
			if (tag == "tag=\"ignore\"")
				next
			end
			if (defin && syn)
				#read until the id line
				while (TRUE)
					nline = fp.readline
					test_line = nline.split(">")
					if (test_line[0] == "<sk")
						puts nline
					end

					spl = nline.split(" ")
					#puts "nline is"
					#puts nline
	
					#puts "spl is"
				   #pp spl

					if (spl[0] == "<id")
						#puts "inside"
						#puts nline
						#break
						ht = Hash.new
						start = 2
						if (spl[1] =~ /col*/)
							start = 3
						end
						#puts start
						term = spl[start].split("=")[1]
						#puts "term is"
						#pp term
						term.gsub!("\"", "")
						offset = start + 1
						for i in (offset..spl.length - 2)
							term += "_"+spl[i].split("\"")[0]
						end
						#puts term
						#term_ = spl[3].split("=")[1]
						id_pre = spl[spl.length - 1]
						id_quot = id_pre.split("=")[1]
						id_woq = id_quot.split("\"")
						id = id_woq[1]
						term_t = id.split(":")[0]
						#get collocation paired with tagged ID
						#col_spl = spl[3].split("=")[1]
						#col = col_spl.split("\"")[1]
						#puts id
					
						ht[term_t] = id
						arr.push(ht)
						break
					end
				end
			else
				next
			end
		when "</def>"
			#puts "changed"
			defin = FALSE
			next
		#matches all the keys with the same glosses
		#when synsets end
		when "</synset>"
			#puts syn
			if (syn == TRUE)
				arr.push(gloss)
				gloss_stripped = gloss.gsub(/\s+/, "")
				gloss_to_sensekey[gloss_stripped] = keys
				keys.each do |key|
					#puts "here"
					#puts keys
					#puts gloss					
					h[key] = arr
					un_tag.each do |key2|
						uf.puts key2 + " " + key
						#un_tagged[key2] = key
						#puts key2
					end
					#h[key] = "something"
				end
				syn = FALSE
				gloss_done = FALSE
				next
			end
		end

	end
end
#pp un_tagged
#@htable = un_tagged
#File.open(name, "w") {|file| Marshal.dump(@htable, file)}
uf.close
gloss_file = "./htable_gloss_to_sk"
@htable = gloss_to_sensekey
File.open(gloss_file, "w+") {|file| Marshal.dump(@htable, file)}
#pp gloss_to_sensekey
return h
	
end
end
#end



#main
if __FILE__ == $0
  d = Dict.new
  #pp d.htable
end
