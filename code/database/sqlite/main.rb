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

def _main()

	db = SQLite3::Database.new("test.db")
	result = db.execute("
		CREATE TABLE USERS(
			USER_ID VARCHAR(1000) NOT NULL,
			EMAIL VARCHAR(1000) NOT NULL,
			NAME VARCHAR(1000) NOT NULL,
			PRIMARY KEY(USER_ID)
		)")
	print("result is: ", result, "\n");

	result = db.execute("INSERT INTO USERS(USER_ID, EMAIL, NAME) VALUES(?, ?, ?)", _generate_user_id(), "jimi.hendrix@docomo.ne.jp", "Jimi Hendrix")
	print("result is: ", result, "\n");

	result = db.execute("DROP TABLE USERS")
	print("result is: ", result, "\n");

	db.close

	puts "--- end ---"
	puts "Ok."

end

_main()
