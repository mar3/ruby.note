#!/usr/bin/env ruby
# coding: utf-8

# require 'date'
require 'aws-sdk-core'
require 'aws-sdk-dynamodb'


class Application

	public def initialize()
		@dynamodb = nil
	end

	def open()
		if @dynamodb != nil
			print("[TRACE] (connection found.)\n")
			return @dynamodb
		end
		print("[TRACE] (a new connection created.)\n")
		# ENV['AWS_REGION'] = 'local'
		# region: ,
		credentials = Aws::Credentials.new("", "")
		@dynamodb = Aws::DynamoDB::Client.new(
			region: "local",
			endpoint: "http://localhost:8000",
			credentials: credentials)
		return @dynamodb
	end

	def init()
		# ========== creating a new table ==========
		begin
			print("[TRACE] listing available operations...\n")
			dynamodb = open()
			print(dynamodb.operation_names, "\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end
		print("\n")
		# ========== creating a new table ==========
		begin
			print("[TRACE] creating a new table...\n")
			parameters = {
				table_name: "sake_table",
				key_schema: [
					{
						attribute_name: "sake_id",
						key_type: "HASH"
					}
				],
				attribute_definitions: [
					{
						attribute_name: "sake_id",
						attribute_type: "S"
					}
				],
				provisioned_throughput: {
					read_capacity_units: 1,
					write_capacity_units: 1,
				}
			}
			dynamodb = open()
			response = dynamodb.create_table(parameters)
			print("[TRACE] created: ", response, "\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end
		print("\n")
	end

	def list_tables()
		# ========== listing tables ==========
		begin
			print("[TRACE] listing tables...\n")
			dynamodb = open()
			tables = dynamodb.list_tables
			print(tables, "\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end
		print("\n")
	end

	def create_records()
		begin
			# dynamodb = open()
			# response = dynamodb.delete_table(parameters)
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end
		print("\n")
	end

	def drop_table()
		# ========== deleting table ==========
		begin
			print("[TRACE] deleting table...\n")
			parameters = {
				table_name: "sake_table"
			}
			dynamodb = open()
			response = dynamodb.delete_table(parameters)
			print("[TRACE] delete: [", response, "]\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end
		print("\n")
	end

	def run()
		print("[TRACE] ### start ###", "\n")
		init()
		create_records()
		list_tables()
		drop_table()
		print("[TRACE] --- end ---", "\n")
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
