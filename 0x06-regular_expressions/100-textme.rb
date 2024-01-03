#!/usr/bin/env ruby
SENDER = ARGV[0].scan(/from:\+*\w*/).join
RECEIVER = ARGV[0].scan(/to:\+*\w*/).join
FLAG = ARGV[0].scan(/flags:(.*?)\]/).join

text_msg = SENDER + "," + RECEIVER + "," + FLAGS
puts text_msg
