#!/usr/bin/ruby
#
#
#
class Stopwatch

	def initialize

		@time = Time.now

	end

	def now()

		now = Time.now
		seconds = now - @time
		milliseconds = (seconds % 1.0) * 1000
		minutes = seconds / 60
		hours = minutes / 60

		return sprintf("%02d:%02d:%02d.%03d",
			hours, minutes, seconds, milliseconds)

	end

end


