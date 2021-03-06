#!/usr/bin/ruby
require 'scanf.rb'
require 'pp'

class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_punc_tag"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
       File.open(name) {|file| Marshal.load(name)}
     end
   end


def build_table

fp = File.open("punc_tag.txt", "r");
data = fp.readlines;
h = Hash.new

data.each do |line|
	next if line.nil?
	words = line.split
	i = 0
	while (i < words.length)
		str = words[1]
		h[str] = 1
		i += 1
	end
end
return h


end
end



#main
if __FILE__ == $0
  d = Dict.new
  pp d.htable
end
