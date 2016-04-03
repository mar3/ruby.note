#!/usr/bin/env ruby
# coding: utf-8

require 'mongo'
require 'date'

def Main()

	Mongo::Logger.logger.level = ::Logger::INFO
	client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'test')
	client['sakaguradb'].drop()

end

Main()
