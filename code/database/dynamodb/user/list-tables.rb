#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'

def main()

	credentials = Aws::Credentials.new('', '')
	db = Aws::DynamoDB::Client.new(region: 'local', endpoint: 'http://localhost:8000', credentials: credentials)
	response = db.list_tables
	response.table_names.each do |e|
		p(e)
	end

end

main()

