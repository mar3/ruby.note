#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'
require 'time'

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO

	client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')

	collection = client['db20160325']

	collection.insert_one({'USER_NAME' => '岸部シロー'})
	collection.insert_one({'USER_NAME' => '岸部一徳'})
	collection.insert_one({'USER_NAME' => '沢田研二'})
	collection.insert_one({'USER_NAME' => '加橋かつみ'})
	collection.insert_one({'USER_NAME' => '森本太郎'})
	collection.insert_one({'USER_NAME' => '瞳みのる'})

	puts collection.find({}).count

	puts '--- end ---'

end

_main()
