#!/usr/bin/env ruby
# coding: utf-8

def debug(unknown)

	print('[TRACE] [')
	print(unknown == nil ? 'nil' : unknown, '] >> [')
	s = unknown.to_s().split(',')
	s.each do |e|
		print('[', e, ']')
	end
	print(']')
	print(' (', s === [], ')')
	# print(' (', s.count(), ')')
	print("\n")

end

def main()

	debug(nil)
	debug('')
	debug('aaaaa,bbbbb,ccccc  ,  dddddd ,   eeee')

end

main()

