#!/usr/bin/env ruby
# coding: utf-8

# sudo apt install libmysqlclient-dev
# sudo gem install mysql # ERROR
# sudo gem install mysql2 # SUCCESS
# mysql -u administrator -p

require 'mysql2'
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

	def initialize()

		@connection = nil

	end

	def close()

		if @connection != nil
			@connection.close()
		end
		@connection = nil

	end

	def open()

		# ========== closing existing session ==========
		close()

		# ========== opening a new connection ==========
		@connection = Mysql2::Client.new(
			:host => '127.0.0.1',
			:database => 'TESTDB',
			:username => 'administrator',
			:password => 'password',
			:encoding => 'utf8')

		return @connection

	end

	def run()

		connection = open()

		# ========== dropping table ==========
		begin
			sql = 'DROP TABLE USERS'
			connection.query(sql)
		rescue Exception => e
			Logger.trace('[TRACE] exception: ', e);
		end

		# ========== creating table ==========
		sql = '
		CREATE TABLE USERS(
			USER_ID VARCHAR(1000) NOT NULL,
			EMAIL VARCHAR(1000) NOT NULL,
			NAME VARCHAR(1000) NOT NULL,
			TIMESTAMP TIMESTAMP NOT NULL,
			PRIMARY KEY(USER_ID)
		)'
		connection.query(sql)

		# ========== creating records ==========
		sql = 'INSERT INTO USERS(USER_ID, EMAIL, NAME, TIMESTAMP) VALUES(?, ?, ?, CURRENT_TIMESTAMP)'
		statement = connection.prepare(sql)
		statement.execute(Generator.new_id(), 'jimi.hendrix@docomo.ne.jp', 'Jimi Hendrix')
		statement.execute(Generator.new_id(), 'nobunaga.oda@gmail.com', 'Nobunaga Oda')
		statement.execute(Generator.new_id(), 'janis.joplin@docomo.ne.jp', 'Janis Joplin')

		# ========== creating records ==========
		sql = 'SELECT * FROM USERS'
		result = connection.query(sql)
		result.each do |row|
			Logger.trace('*** fetch ***', "\n", row.pretty_inspect())
		end

	end

	def fin()

		close()

	end

end

def _main()

	begin

		app = Application.new()
		app.run()

	rescue Exception => e

		Logger.trace('ERROR: ', e)
		raise

	ensure

		app.fin()

	end
end

_main()
