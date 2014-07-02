#!/usr/bin/ruby
# coding: utf-8

module Logger

	def Logger.info(*messages)

		now = Time.now;
		timestamp = sprintf("%04d-%02d-%02d %02d:%02d:%02d.%03d",
			now.year, now.month, now.day,
			now.hour, now.min, now.sec, now.usec / 1000);
		name = sprintf("log-%04d%02d%02d.log",
			now.year, now.month, now.day);
		stream = File.new(name, "a+");
		stream.print(timestamp, " [info] ", messages.join, "\n");
		stream.close();

	end

end

