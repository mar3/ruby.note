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

	def create_sake_item(sake_name, factory_name, factory_prefecture, factory_address)
		db = open()
		new_id = Generator.new_id()
		item = {
			sake_id: new_id,
			sake_name: sake_name,
			factory: {
				factory_name: factory_name,
				factory_address: factory_address
			}
		}
		parameters = {table_name: 'sake_table', item: item}
		response = db.put_item(parameters)
		# Logger.trace('new item is: ', response, "\n")
	end

	def test0()
		# ========== DROPPING TABLE ==========
		begin
			drop_table('sake_table')
		end
		# ========== CREATING A NEW TABLE ==========
		begin
			Logger.trace('$$$ creating a new table $$$')
			parameters = {
				table_name: 'sake_table',
				key_schema: [
					{attribute_name: 'sake_id', key_type: 'HASH'},
				],
				attribute_definitions: [
					{attribute_name: 'sake_id', attribute_type: 'S'},
				],
				provisioned_throughput: {
					read_capacity_units: 1, write_capacity_units: 1,
				},
			}
			db = open()
			response = db.create_table(parameters)
			Logger.trace('created: ', "\n", response.pretty_inspect())
		end
		# ========== ADDING A NEW INDEX TO TABLE ==========
		begin
			Logger.trace('$$$ adding a new index to table $$$')
			parameters = {
				table_name: 'sake_table',
				attribute_definitions: [
					{attribute_name: 'sake_name', attribute_type: 'S'}
				],
				global_secondary_index_updates: [
					{
						create: {
							index_name: 'sake_name_index',
							key_schema: [
								{attribute_name: 'sake_name', key_type: 'HASH'},
							],
							projection: {projection_type: 'KEYS_ONLY'},
							provisioned_throughput: {read_capacity_units: 1, write_capacity_units: 1}
						}
					}
				]
			}
			db = open()
			response = db.update_table(parameters)
			Logger.trace('created: ', "\n", response.pretty_inspect())
		end
		# ========== ADDING A NEW INDEX TO TABLE ==========
		begin
			Logger.trace('$$$ adding a new index to table $$$')
			parameters = {
				table_name: 'sake_table',
				attribute_definitions: [
					{attribute_name: 'prefecture_name', attribute_type: 'S'}
				],
				global_secondary_index_updates: [
					{
						create: {
							index_name: 'factory_prefecture_index',
							key_schema: [
								{attribute_name: 'prefecture_name', key_type: 'HASH'},
							],
							projection: {projection_type: 'KEYS_ONLY'},
							provisioned_throughput: {read_capacity_units: 1, write_capacity_units: 1}
						}
					}
				]
			}
			db = open()
			response = db.update_table(parameters)
			Logger.trace('created: ', "\n", response.pretty_inspect())
		end
		# ========== CREATING ITEMS ==========
		begin
			Logger.trace('$$$ creating items $$$')
			create_sake_item('旭若松', '那賀酒造', '徳島県', '771-5201 徳島県那賀郡那賀町和食町３５')
			create_sake_item('十旭日', '旭日酒造', '島根県', '693-0001 島根県出雲市今市町662')
			create_sake_item('宗玄', '宗玄酒造', '石川県', '927-1225 石川県珠洲市宝立町宗玄24-22')
			create_sake_item('秋鹿', '秋鹿酒造', '大阪府', '大阪府豊能郡能勢町倉垣1007')
			create_sake_item('隆', '川西屋酒造', '神奈川県', '258-0113 神奈川県足柄上郡山北町山北２５０')
			create_sake_item('', '', '', '')
			create_sake_item('', '', '', '')
		end
		# ========== SEARCHING ITEMS ==========
		begin
			Logger.trace('$$$ searching items $$$')
			db = open()
			parameters = {
				table_name: 'sake_table',
				index_name: 'sake_name_index',
				key_condition_expression: 'sake_name = :value1',
				expression_attribute_values: {
					':value1' => '旭若松'
				}
			}
			item_count = 0
			response = db.query(parameters)
			response.items.each do |e|
				Logger.trace('    - ', e)
				item_count = item_count + 1
			end
			Logger.trace(item_count, ' item(s) found.', "\n")
		end
		Logger.trace('Ok.')
	end

	def exists_table(table_name)
		db = open()
		db.list_tables.each do |e|
			if e.table_names[0] == table_name
				return true
			end
		end
		return false
	end

	def drop_table(table_name)
		if !exists_table(table_name)
			# Logger.trace('テーブル [', table_name, '] は存在しません。')
			return
		end
		Logger.trace('$$$ deleting table $$$')
		db = open()
		parameters = {table_name: table_name}
		db.delete_table(parameters)
		Logger.trace('テーブル [', table_name, '] を削除しました。')
	end

	def run()
		Logger.trace('### start ###', "\n")
		begin
			test0()
		rescue Exception => e
			raise
		end
		Logger.trace('--- end ---', "\n")
	end

end

def main()
	app = Application.new()
	app.run()
end

main()

