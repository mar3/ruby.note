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

	def exists_table(table_name)
		db = open()
		response = db.list_tables
		puts response
		response.table_names.each do |e|
			Logger.trace('テーブル: [', e, ']')
			if e == table_name
				return true
			end
		end
		return false
	end

	def drop_table(table_name)
		if !exists_table(table_name)
			Logger.trace('テーブル [', table_name, '] は存在しません。')
			return
		end
		Logger.trace('$$$ deleting table $$$')
		db = open()
		parameters = {table_name: table_name}
		db.delete_table(parameters)
		Logger.trace('テーブル [', table_name, '] を削除しました。')
	end

	def init()
		# ========== DROPPING TABLE ==========
		begin
			drop_table('users_02')
		end
		# ========== CREATING A NEW TABLE ==========
		begin
			Logger.trace('$$$ creating a new table $$$')
			parameters = {
				table_name: 'users_02',
				key_schema: [
					{attribute_name: 'user_id', key_type: 'HASH'},
				],
				attribute_definitions: [
					{attribute_name: 'user_id', attribute_type: 'S'},
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
				table_name: 'users_02',
				attribute_definitions: [
					{attribute_name: 'email', attribute_type: 'S'}
				],
				local_secondary_index_updates: [
					{
						create: {
							index_name: 'email_index',
							key_schema: [
								{attribute_name: 'email', key_type: 'HASH'},
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
				table_name: 'users_02',
				attribute_definitions: [
					{attribute_name: 'prefecture', attribute_type: 'S'}
				],
				local_secondary_index_updates: [
					{
						create: {
							index_name: 'prefecture_index',
							key_schema: [
								{attribute_name: 'prefecture', key_type: 'HASH'},
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
	end

	def create_item(user_name, email, prefecture, phone)
		db = open()
		new_id = Generator.new_id()
		item = {
			user_id: new_id,
			user_name: user_name,
			email: email,
			prefecture: prefecture,
			phone: phone,
		}
		parameters = {table_name: 'users_02', item: item}
		response = db.put_item(parameters)
		Logger.trace('(+)')
		# Logger.trace('new item is: ', response, "\n")
	end

	def query_by_prefecture(prefecture)
		db = open()
		parameters = {
			table_name: 'users_02',
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
		now = Time.now()
		elapsed = now - @time
		ms = (now - @time) * 1000;
		sec = ms / 1000;
		ms = ms % 1000;
		min = sec / 60;
		sec = sec % 60;
		hr = min / 60;
		min = min % 60;
		return sprintf('%02d:%02d:%02d.%03d', $hr, $min, $sec, $ms);
		# return elapsed
	end

end

class Application

	def test0()

		# ========== データベースを初期化します ==========
		model = Users.new()
		model.init()

		# ========== ユーザー情報を登録します ==========
		file = File.open('USERS.tsv', 'r')
		items = 0
		file.each_line do |line|
			line = line.rstrip()
			fields = line.split("\t")
			user_name = fields[0]
			furigana = fields[1]
			email = fields[2]
			prefecture = fields[7]
			phone = fields[8]
			model.create_item(user_name, email, prefecture, phone)
			items = items + 1
			if 100 <= items
				break
			end
		end
		file.close()
		print(items, ' account(s) created.', "\n")
		# ========== SEARCHING ITEMS ==========
		begin
			Logger.trace('$$$ searching items $$$')
			items = model.query_by_prefecture('滋賀県')
			item_count = 0
			items.each do |e|
				Logger.trace('    - ', e)
				item_count = item_count + 1
			end
			Logger.trace(item_count, ' item(s) found.', "\n")
		end
		Logger.trace('Ok.')
	end

	def run()
		Logger.trace('### start ###')
		s = Stopwatch.new()
		begin
			test0()
		rescue Exception => e
			raise
		end
		Logger.trace('処理時間: ', s.to_s())
		Logger.trace('--- end ---')
	end

end

def main()
	app = Application.new()
	app.run()
end

main()
