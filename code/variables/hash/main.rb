#!/usr/bin/env ruby
# coding: utf-8

require 'json'

def main()

	var = {
		key01: 'value-01',
		'key 02': 'value-02',
		'key 03' => 9.123
	}
	var['key04'] = 'value of key04'
	print(var, "\n")
	print(var.to_json, "\n")

end

main()

