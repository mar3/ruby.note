#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'json'

# Encoding.default_external = Encoding::UTF_8

def Main()

	Mongo::Logger.logger.level = ::Logger::INFO
	client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
	collection = client['sakaguradb']
	condition = {"会社名" => /会社/, "銘柄" => /山田錦/}
	collection.find(condition).each do |e|
		puts JSON.pretty_unparse(e, :indent=>'    ')
	end

end

Main()
