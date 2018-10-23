#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'
require 'pp'


class Logger

	def Logger.trace(*parameters)

		print(Time.now().strftime('%Y-%m-%d %H:%M:%S.%L'), ' [TRACE] ', *parameters, "\n")

	end

end

class Application

	public def initialize()

		@dynamodb = nil

	end

	def open()

		if @dynamodb != nil
			return @dynamodb
		end
		credentials = Aws::Credentials.new('', '')
		@dynamodb = Aws::DynamoDB::Client.new(region: 'local', endpoint: 'http://localhost:8000', credentials: credentials)
		return @dynamodb

	end

	def list_tables()

		dynamodb = open()
		response = dynamodb.list_tables
		response.table_names.each do |e|
			print('    ', e, "\n")
		end

	end

	def run()

		list_tables()

	end

end

def main()

	app = Application.new()
	app.run()

end

main()
