#!/usr/bin/env ruby
SENDER = ARGV[0].scan(/from:\+*\w*/).join[5..-1]
RECEIVER = ARGV[0].scan(/to:\+*\w*/).join[3..-1]
FLAG = ARGV[0].scan(/flags:(.*?)\]/).join

text_msg = SENDER + "," + RECEIVER + "," + FLAGS
puts text_msg