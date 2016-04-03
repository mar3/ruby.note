#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'
require 'time'

def _insert(collection, user_name, birthplace)

	e = {
		'USER_NAME' => user_name,
		'BIRTHBLACE' => birthplace
	}
	collection.insert_one(e)

end

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO
	client = Mongo::Client.new(
		['127.0.0.1:27017'],
		:database => 'test',
		:wtimeout => 500)
	collection = client['db20160325']
	insert = lambda { |user_name, birthplace| _insert(collection, user_name, birthplace) }
	insert.call('岸部シロー', '京都府京都市')
	insert.call('岸部一徳', '京都府京都市')
	insert.call('沢田研二', '鳥取県鳥取市')
	insert.call('加橋かつみ', '大阪府堺市')
	insert.call('森本太郎', '京都府京都市')
	insert.call('瞳みのる', '京都府')

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
