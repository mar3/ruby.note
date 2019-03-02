#!/usr/bin/env ruby
# coding: utf-8

require 'csv'

def main()

	file = CSV.open('test.csv')
	for line in file
		print(line, "\n")
	end
	file.close()

end 

main()
