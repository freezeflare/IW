#!/usr/bin/ruby

require 'rubygems'
require 'wordnet'

#main 

if __FILE__ == $0

lex = WordNet::Lexicon.new

orig = lex.lookup_synsets(nil,[Regexp.new(".*"), WordNet::Noun])
fp = File.open("./gloss.txt", "w+")


orig.each do |syn|
fp.puts syn.gloss
end

end

