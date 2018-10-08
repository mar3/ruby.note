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
			return @dynamodb
		end
		# ENV['AWS_REGION'] = 'local'
		# region: ,
		credentials = Aws::Credentials.new("", "")
		@dynamodb = Aws::DynamoDB::Client.new(
			region: "local",
			endpoint: "http://localhost:8000",
			credentials: credentials)
		return @dynamodb
	end

	def run()

		print("[TRACE] ### start ###", "\n")

		dynamodb = open()

		# ========== creating a new table ==========
		begin
			print("# listing available operations...\n")
			print(dynamodb.operation_names, "\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end

		# ========== creating a new table ==========
		begin
			print("\n")
			print("# creating a new table...\n")
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
			response = dynamodb.create_table(parameters)
			print("[TRACE] created: ", response, "\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end

		# ========== listing tables ==========
		begin
			print("\n")
			print("# listing tables...\n")
			tables = dynamodb.list_tables
			print(tables, "\n")
			print("\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end

		# ========== droping table ==========
		begin
			print("\n")
			print("# deleting table...\n")
			parameters = {
				table_name: "sake_table"
			}
			response = dynamodb.delete_table(parameters)
			print("[TRACE] delete: [", response, "]\n")
		rescue Exception => e
			print("[TRACE] error: ", e, "\n")
		end

		# ========== end ==========
		# print("Ok.\n")

		print("[TRACE] --- end ---", "\n")

	end

end

def main()

	app = Application.new()
	app.run()

end

main()
