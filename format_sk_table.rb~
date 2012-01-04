#!/usr/bin/ruby
require 'pp'

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


def build_table

fp = File.open("./gloss-tag/WordNet-3.0/glosstag/standoff/index.bysk.tab", "r");
#data = fp.readlines;
h = Hash.new

fp.each do |line|
	next if line.nil?
	word_with_stuff = line.split(" ")
	#puts ("w/ stuff")
	#pp word_with_stuff
	word_with_per = word_with_stuff[0].split(":")[0]
	word = word_with_per.split("%")[0]
	
	arr = Array.new
	arr.push(word_with_stuff[1])

	h[word].nil? ? h[word] = arr : h[word].push(word_with_stuff[1])
end
return h


end
end



#main
if __FILE__ == $0
  d = Dict.new
  pp d.htable
end

