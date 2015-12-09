#!/usr/bin/env ruby
# coding: utf-8


require 'json'

def main()

	values = {
		'field-01' => 'value 01',
		'field-02' => 'value 02',
		'住所' => '石川県野々市市末松1丁目A-B-C',
	}

	#
	# Ruby オブジェクトを表示
	#

	print(values, "\n")

	#
	# Ruby オブジェクトを JSON に変換
	#

	content = values.to_json
	print(content, "\n")

	#
	# JSON 文字列を Ruby オブジェクトに変換
	#

	values = JSON.parse(content)
	print(values, "\n")

end

main()
