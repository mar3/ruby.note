#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-dynamodb'
require 'securerandom'


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

class Users

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

	def query_by_prefecture(prefecture)
		db = open()
		parameters = {
			table_name: 'users',
			index_name: 'prefecture_index',
			key_condition_expression: 'prefecture = :value1',
			expression_attribute_values: {':value1' => prefecture}
		}
		item_count = 0
		response = db.query(parameters)
		return response.items
	end

end

class Stopwatch

	def initialize()
		@time = Time.now()
	end
	def to_s()
		current = Time.now()
		elapsed = current - @time
		return elapsed
	end

end

class Application

	def test0()
		model = Users.new()
		items = model.query_by_prefecture('長崎県')
		item_count = 0
		items.each do |e|
			Logger.trace('    - ', e)
			item_count = item_count + 1
		end
		Logger.trace(item_count, ' item(s) found.')
	end

	def run()
		s = Stopwatch.new()
		test0()
		print(s.to_s(), "\n")
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
