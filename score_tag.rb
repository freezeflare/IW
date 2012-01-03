#!/usr/bin/ruby
require 'pp'
require 'rubygems'
require 'rbtagger'
require 'wordnet'
=begin
class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_sk_untagged"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
       File.open(name) {|file| Marshal.load(name)}
     end
   end

=end
def set_up

fp = File.open("./untagged_list", "r");
xml = File.open("./htable_xml", "r");

lex = WordNet::Lexicon.new
xml_htable = Marshal.load(xml)

#data = fp.readlines;

tagger = Brill::Tagger.new

fp.each do |line|
	next if line.nil?
	word_with_stuff = line.split(" ")
	term = word_with_stuff[0]
	sk = ""
	pos = ""
	ignore = FALSE
	term_regexp = ""
	if (word_with_stuff.length() == 2)
		sk = word_with_stuff[1]
		arr = xml_htable[sk]
		tagged = tagger.tag(arr[arr.length() - 1])
		term_regexp = term + "*"
		#puts term_regexp
		tagged.each do |tup|
			#pp tup
			if (!tup.first.match(term_regexp).nil?)
				case tup[1]
				when "NN", "NNS", "NNP", "NNPS"
					pos = "noun"
				when "VB", "VBD", "VBG", "VBN", "VBP", "VBZ"
					pos = "verb"
				when "JJ", "JJR", "JJS"
					pos = "adj"
				when "RB", "RBR", "RBS"
					pos = "adv"
				else
					ignore = TRUE
				end
			end
			#if (pos == "")
			#	pos = "FUCKING A"
			#end
			#next if (pos == "")
		end
	else
		pos = word_with_stuff[1]
		sk = word_with_stuff[2]
	end
	next if (pos == "" || ignore)
	#puts "term"
	puts term_regexp if (term_regexp !="")
	#puts "POS"
	puts pos
	end
end
#end



#main
if __FILE__ == $0
  set_up
  #pp d.htable
end

