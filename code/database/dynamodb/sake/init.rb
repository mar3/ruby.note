#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-core'
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

class Application

	public def initialize()
		@dynamodb = nil
	end

	def open()
		if @dynamodb != nil
			Logger.trace('(connection found.)')
			return @dynamodb
		end
		Logger.trace('(a new connection created.)')
		# ENV['AWS_REGION'] = 'local'
		# region: ,
		credentials = Aws::Credentials.new('', '')
		@dynamodb = Aws::DynamoDB::Client.new(
			region: 'local',
			endpoint: 'http://localhost:8000',
			credentials: credentials)
		return @dynamodb
	end

	def init()
		# ========== creating a new table ==========
		begin
			Logger.trace('$$$ listing available operations $$$')
			dynamodb = open()
			Logger.trace(dynamodb.operation_names)
		rescue Exception => e
			Logger.trace('error: ', e)
		end
		# ========== creating a new table ==========
		begin
			Logger.trace('creating a new table...')
			parameters = {
				table_name: 'sake_table',
				key_schema: [
					{
						attribute_name: 'sake_id',
						key_type: 'HASH'
					}
				],
				attribute_definitions: [
					{
						attribute_name: 'sake_id',
						attribute_type: 'S'
					}
				],
				provisioned_throughput: {
					read_capacity_units: 1,
					write_capacity_units: 1,
				}
			}
			dynamodb = open()
			response = dynamodb.create_table(parameters)
			Logger.trace('created: ', response)
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def list_tables()
		# ========== listing tables ==========
		begin
			Logger.trace('$$$ listing tables $$$')
			dynamodb = open()
			tables = dynamodb.list_tables
			Logger.trace(tables)
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def create_records()
		begin
			Logger.trace('$$$ creating items $$$')
			dynamodb = open()
			new_id = Generator.new_id()
			parameters = {
				expression_attribute_names: {
					"#SAKE_NAME" => "sake_name",
					"#PREFECTURE" => "prefecture"
				}, 
				expression_attribute_values: {
					":sake_name" => {
						s: '旭若松'
					},
					":prefecture" => {
						s: 'tokushima'
					}
				},
				key: {
					"sake_id" => {
						s: new_id,
					}
				},
				return_values: "ALL_NEW",
				table_name: "sake_table",
				update_expression: "SET #SAKE_NAME = :sake_name, #PREFECTURE = :prefecture"
			}
			response = dynamodb.update_item(parameters)
			Logger.trace('REGISTER: ', response)
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def drop_table()
		# ========== deleting table ==========
		begin
			Logger.trace('$$$ deleting table $$$')
			parameters = {
				table_name: 'sake_table'
			}
			dynamodb = open()
			response = dynamodb.delete_table(parameters)
			Logger.trace('delete: [', response, ']')
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def run()
		Logger.trace('### start ###')
		begin
			init()
			create_records()
			list_tables()
			drop_table()
		rescue Exception => e
			Logger.trace('error: ', e)
		end
		Logger.trace('--- end ---')
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
