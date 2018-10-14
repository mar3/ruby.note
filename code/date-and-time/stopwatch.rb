#!/usr/bin/env ruby
# coding: utf-8

require 'date'

class Stopwatch

	def initialize()
		@time = Time.now()
	end

	def to_s()
		current = Time.now()
		elapsed = current - @time
		millisec = elapsed * 1000
		sec = millisec / 1000
		millisec = millisec % 1000
		min = sec / 60
		sec = sec % 60
		hour = min / 60
		min = min % 60
		return sprintf('%02d:%02d:%02d.%03d', hour, min, sec, millisec);
	end

end

def main()
	s = Stopwatch.new()
	sleep(0.712)
	print(s, "\n")
end

main()
