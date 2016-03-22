#!/usr/bin/env ruby
# coding: utf-8

require 'date'
require 'time'

def _main()

	puts Date.today.to_s
	puts Date::new(2000, 1, 1).to_s
	# puts Date::exist?(2016, 1, 1)
	puts Time.now()
	puts Time.now().to_s
	puts Time.now().strftime('%Y-%m-%d %H:%M:%S.%L')
	puts Time.parse('2016-01-01 01:12:34.777').to_s
	puts Time.parse('2016-02-29 01:12:34.777').to_s
	puts Time.parse('2016-02-30 01:12:34.777').to_s

end

_main()
