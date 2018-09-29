#!/usr/bin/env ruby
# coding: utf-8

require 'securerandom'
require 'sqlite3'

# sudo apt install sqlite3
# sudo apt install libsqlite3-dev
# sudo gem install sqlite3

def _generate_user_id()
	return SecureRandom.uuid
end

def _init()
	connection = SQLite3::Database.new("test.db")
	sql = "
	CREATE TABLE USERS(
		USER_ID VARCHAR(1000) NOT NULL,
		EMAIL VARCHAR(1000) NOT NULL,
		NAME VARCHAR(1000) NOT NULL,
		PRIMARY KEY(USER_ID)
	)"
	result = connection.execute(sql)
	print("[TRACE] result is: ", result, "\n");
	connection.close
end

def _insert_records()
	connection = SQLite3::Database.new("test.db")
	sql = "INSERT INTO USERS(USER_ID, EMAIL, NAME) VALUES(?, ?, ?)"
	result = connection.execute(sql, _generate_user_id(), "jimi.hendrix@docomo.ne.jp", "Jimi Hendrix")
	print("[TRACE] result is: ", result, "\n");
	result = connection.execute(sql, _generate_user_id(), "freddie.mercury@icloud.com", "Freddie Mercury")
	print("[TRACE] result is: ", result, "\n");
	result = connection.execute(sql, _generate_user_id(), "mal.waldron@gmail.com", "Mal Waldron")
	print("[TRACE] result is: ", result, "\n");
	connection.close
end

def _enumerate_records()
	connection = SQLite3::Database.new("test.db")
	sql = "SELECT * FROM USERS"
	result = connection.execute(sql)
	# print("[TRACE] result is: ", result, "\n");
	result.each { |row|
		print(row, "\n")
	}
	connection.close
end

def _drop()
	connection = SQLite3::Database.new("test.db")
	begin
		sql = "DROP TABLE USERS"
		result = connection.execute(sql)
		print("[TRACE] result is: ", result, "\n");
	rescue Exception => e
		print("[TRACE] ", e, "\n")
	end
	connection.close
end

def _main(argv)
	print("[TRACE] ### start ###\n")
	begin
		_drop()
		_init()
		_insert_records()
		_enumerate_records()
		_drop()
	rescue Exception => e
		print("[TRACE] ", e, "\n")
		print("[ERROR] error!!!\n")
	ensure
		print("[TRACE] (ensure)\n")
	end
	print("[TRACE] --- end ---\n")
end

_main(ARGV)
