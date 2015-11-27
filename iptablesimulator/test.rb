#!/bin/usr/env ruby
File.open("iptables.sh").each do |line|
	puts line
end
