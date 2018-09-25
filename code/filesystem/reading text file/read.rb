#!/usr/bin/env ruby
# coding: utf-8

def _log(*args)

	timestamp = Time.now().strftime('%Y-%m-%d %H:%M:%S.%L')
	print(timestamp, " [trace] ", *args, "\n")

end

def _dump(path)

	file = File.open(path, "r")
	file.each_line{ |line|
		line = line.rstrip()
		# print("[", line, "]", "\n")
	}
	file.close()

end

def _main()

	_log("### start ###")

	_dump("DATA")

	_log("--- end ---")

end

_main()
