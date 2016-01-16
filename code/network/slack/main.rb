#!/usr/bin/env ruby
# coding: utf-8

require 'uri'
require 'net/http'
require 'json'

def _main()

	# 準備
	values = {'text' => 'おーーーーーーーーー'}
	content_text = JSON.generate(values)
	url = `cat slack.url`
	request_data = Net::HTTP::Post.new(uri.request_uri)
	request_data['Content-Type'] = 'application/json'
	request_data.body = content_text

	# 送信
	http_client = Net::HTTP.new(uri.host, uri.port)
	http_client.use_ssl = true
	response_data = http_client.request(request_data)
	print(response_data.message, "\n")
 
end 

_main()
