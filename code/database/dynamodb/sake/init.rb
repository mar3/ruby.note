#!/usr/bin/env ruby
# coding: utf-8

require 'aws-sdk-core'
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
			# Logger.trace('(connection found.)')
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

	def show_available_operations()
		begin
			Logger.trace('$$$ listing available operations $$$')
			dynamodb = open()
			Logger.trace(dynamodb.operation_names, "\n")
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def init_bak()
		begin
			Logger.trace('$$$ creating a new table $$$')
			parameters = {
				table_name: 'sake_table',
				key_schema: [
					{
						attribute_name: 'sake_id',
						key_type: 'HASH'
					},
					{
						attribute_name: 'sake_name',
						key_type: 'String'
					}
				],
				attribute_definitions: [
					{
						attribute_name: 'sake_id',
						attribute_type: 'S'
					},
					{
						attribute_name: 'sake_name',
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
			Logger.trace('created: ', response, "\n")
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def init()
		begin
			Logger.trace('$$$ creating a new table $$$')
			parameters = {
				table_name: 'sake_table',
				key_schema: [
					{attribute_name: 'sake_id', key_type: 'HASH'},
					{attribute_name: 'sake_name', key_type: 'String'}
				],
				attribute_definitions: [
					{attribute_name: 'sake_id', attribute_type: 'S'},
					{attribute_name: 'sake_name', attribute_type: 'S'}
				],
				provisioned_throughput: {
					read_capacity_units: 1, write_capacity_units: 1,
				},
				global_secondary_indexes: [
					{
						index_name: "sake_name_index",
						key_schema: [
							{attribute_name: "sake_name", key_type: "HASH"},
						],
						projection: {
							"projection_type": "ALL"
						},
						provisioned_throughput: {
							"read_capacity_units": 1, "write_capacity_units": 1
						}
					}
				]
			}
			dynamodb = open()
			response = dynamodb.create_table(parameters)
			Logger.trace('created: ', "\n", PP.pp(response), "\n")
		rescue Exception => e
			Logger.trace('error: ', e, "\n")
		end
	end

	def list_tables()
		begin
			Logger.trace('$$$ listing tables $$$')
			dynamodb = open()
			tables = dynamodb.list_tables
			Logger.trace(tables, "\n")
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def create_items()
		begin
			Logger.trace('$$$ creating items $$$')
			dynamodb = open()
			new_id = Generator.new_id()
			item = {
				sake_id: new_id,
				sake_name: "旭若松",
				factory: {
					name: "那賀酒造",
					address: "徳島県 那賀郡 xxx..." 
				}
			}
			parameters = {
				table_name: "sake_table",
				item: item
			}
			response = dynamodb.put_item(parameters)
			Logger.trace('new item is: ', response, "\n")
		rescue Exception => e
			Logger.trace('error: ', e)
		end
	end

	def search_items()
		begin
			Logger.trace('$$$ searching items $$$')
			dynamodb = open()
			parameters = {
				table_name: "sake_table",
				index_name: "sake_name_index",
				key_condition_expression: "sake_name = :value1",
				expression_attribute_values: {":value1" => '旭若松'}
			}
			item_count = 0
			response = dynamodb.query(parameters)
			response.items.each do |e|
				Logger.trace('    - ', e)
				item_count = item_count + 1
			end
			Logger.trace(item_count, ' item(s) found.', "\n")
		rescue Exception => e
			Logger.trace('error: ', e, "\n")
		end
	end

	def drop_table()
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
		Logger.trace('### start ###', "\n")
		begin
			show_available_operations()
			init()
			list_tables()
			create_items()
			search_items()
			drop_table()
		rescue Exception => e
			Logger.trace('error: ', e)
		end
		Logger.trace('--- end ---', "\n")
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
