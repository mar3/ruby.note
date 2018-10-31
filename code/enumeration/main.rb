#!/usr/bin/env ruby
# cpding: utf-8

def enumerate()
	items = [
		'aaa',
		'bbb',
		'ccc',
		'ddd',
		'eee',
	]
	return items
end

def main()
	items = enumerate()
	items.each do |e|
		puts e
	end
end

main()

