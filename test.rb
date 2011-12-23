#!/usr/bin/ruby
require 'rbtagger'

tagger = Brill::Tagger.new

puts tagger.tag("fUCK THIS CRAP")
