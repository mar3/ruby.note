#!/usr/bin/env ruby
# coding: utf-8

def trace(*args)

	timestamp = Time.now().strftime("%Y-%m-%d %H:%M:%S.%L")

	print(timestamp, " [TRACE] ")
	print(*args)
	print("\n")

end

def main()

	trace("### BEGIN ###")
	
	xxx = "XXX"
	trace("文字列: [", xxx, "]")
	
	timestamp = Time.now()
	trace("current timestamp is [", timestamp, "]")
	
	trace("--- END ---")

end

main()
