#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'
require 'securerandom'
require 'pp'


class Logger

	def Logger.trace(*parameters)
		print(Time.now().strftime('%Y-%m-%d %H:%M:%S.%L'), ' [TRACE] ', *parameters, "\n")
	end

end

class Generator

	def Generator.new_id()
		return SecureRandom.uuid()
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
		tables = dynamodb.list_tables
		print(PP.pp(tables), "\n")
		tables.item.each do |e|
			print('    ', e, "\n")
		end
		print("\n")
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
