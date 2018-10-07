#!/usr/bin/env ruby
# coding: utf-8

# require 'date'
require 'aws-sdk-core'
require 'aws-sdk-dynamodb'

def main()

	# ENV['AWS_REGION'] = 'local'
	# region: ,

	# access_key_id
	# secret_access_key
	# session_token
	credentials = Aws::Credentials.new("", "")

	dynamodb = Aws::DynamoDB::Client.new(region: "local", endpoint: "http://localhost:8000", credentials: credentials)

	print(dynamodb.operation_names, "\n")

	# ========== creating a new table ==========
	print("#\n")
	print("# creating a new table...\n")
	print("#\n")
	parameters = {
		table_name: "sake_table",
		key_schema: [
			{
				attribute_name: "sake_id",
				key_type: "HASH"
			},
			{
				attribute_name: "sake_name",
				key_type: "RANGE"
			},
			{
				attribute_name: "timestamp",
				key_type: "RANGE"
			}
		],
		attribute_definitions: [
			{
				attribute_name: "sake_id",
				attribute_type: "S"
			},
			{
				attribute_name: "sake_name",
				attribute_type: "S"
			},
			{
				attribute_name: "timestamp",
				attribute_type: "N"
			}
		],
		provisioned_throughput: {
			read_capacity_units: 1,
			write_capacity_units: 1,
		}
	}
	response = dynamodb.create_table(parameters)
	piint("[TRACE] created: ", response, "\n")

	# ========== listing tables ==========
	print("\n")
	print("#\n")
	print("# listing tables...\n")
	print("#\n")
	tables = dynamodb.list_tables
	print(tables, "\n")
	print("\n")

	dynamodb.drop_table(parameters)

	# print("Ok.\n")

end

main()
