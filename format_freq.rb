#!/usr/bin/ruby


class Dict
   attr_accessor :htable
   def initialize
     name = "./htable_file"
     if !File.exists? name
       @htable = build_table
       File.open(name, "w") {|file| Marshal.dump(@htable, file)}
     else
       File.open(name) {|file| Marshal.load(name)}
     end
   end


def build_table
fp = File.open("lemma.txt", "r");

data = fp.readlines;
h = Hash.new
data.each do |line|
next if line.nil?
words_w_stuff = line.split
freq = words_w_stuff[1]
word = words_w_stuff[2]
pos = words_w_stuff[3]
h["#{word}_#{pos}"] = freq;
end

end
end



#main
if __FILE__ == $0
  d = Dict.new
  puts d.htable
end

