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

	_update(collection, '岸部シロー', {'BIRTH' => Time.local(1949, 6, 7)})
	_update(collection, '岸部一徳', {'BIRTH' => Time.local(1947, 1, 9)})
	_update(collection, '沢田研二', {'BIRTH' => Time.local(1948, 6, 25)})
	_update(collection, '加橋かつみ', {'BIRTH' => Time.local(1948, 2, 4)})
	_update(collection, '森本太郎', {'BIRTH' => Time.local(1946, 11, 18)})
	_update(collection, '瞳みのる', {'BIRTH' => Time.local(1946, 9, 22)})

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
