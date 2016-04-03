#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'
require 'time'

def _update(collection, user_name, attributes)

	e = collection.find({'USER_NAME' => user_name})
	if e == nil
		return
	end

	e.update_one({'$set' => attributes})

end

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO

	client = Mongo::Client.new(
		['127.0.0.1:27017'],
		:database => 'test',
		:wtimeout => 500
	)

	collection = client['db20160325']

	_update(collection, '岸部シロー', {'BIRTHPLACE' => '京都府京都市'})
	_update(collection, '岸部一徳', {'BIRTHPLACE' => '京都府京都市'})
	_update(collection, '沢田研二', {'BIRTHPLACE' => '鳥取県鳥取市'})
	_update(collection, '加橋かつみ', {'BIRTHPLACE' => '大阪府堺市'})
	_update(collection, '森本太郎', {'BIRTHPLACE' => '京都府京都市'})
	_update(collection, '瞳みのる', {'BIRTHPLACE' => '京都府'})

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
