#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'
require 'time'

def _insert(collection, user_name)

	e = {'USER_NAME' => user_name}
	collection.insert_one(e)

end

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO
	client = Mongo::Client.new(
		['127.0.0.1:27017'], :database => 'test')
	collection = client['db20160325']
	insert = lambda { |user_name, birthplace| _insert(collection, user_name) }
	insert.call('岸部シロー')
	insert.call('岸部一徳')
	insert.call('沢田研二')
	insert.call('加橋かつみ')
	insert.call('森本太郎')
	insert.call('瞳みのる')

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
