#!/usr/bin/env ruby
# coding: utf-8

require 'uri'
require 'net/http'

def _main()

	url = 'https://www.google.com/search?q=jenkins'
	request_data = Net::HTTP::GET.new(uri.request_uri)
	#request_data['Content-Type'] = 'application/json'
	request_data.body = content_text

	http_client = Net::HTTP.new(uri.host, uri.port)
	http_client.use_ssl = true
	response_data = http_client.request(request_data)

	print(response_data.message, "\n")
 
end 

_main()
