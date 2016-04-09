#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'json'
require 'time'

# Encoding.default_external = Encoding::UTF_8

def _main()

	Mongo::Logger.logger.level = ::Logger::INFO
	client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
	collection = client['db20160325']
	count = 0
	collection.find({BIRTHPLACE: /京都/}).sort({USER_NAME: 1}).each do |e|
		e.delete("_id")
		# puts JSON.pretty_unparse(e, :indent => "    ")
		puts JSON.pretty_generate(e, :indent => "    ")
		# puts JSON.generate(e)
		count += 1
	end
	print '', count, ' indices found.', "\n"

end

_main()
