#!/usr/bin/env ruby
# coding: utf-8


require 'json'

def main()

	values = {
		'field-01' => 'value 01',
		'field-02' => 'value 02',
		'住所' => '石川県野々市市末松1丁目A-B-C',
	}

	print(values.to_json, "\n")

end

main()
