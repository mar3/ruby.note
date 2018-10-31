#!/usr/bin/env ruby
# coding: utf-8

def main()

	s = 'aaaaa,bbbbb,ccccc  ,  dddddd ,   eeee'
	s = s.split(',')
	s.each do |e|
		print('[', e, ']', "\n")
	end

end

main()

