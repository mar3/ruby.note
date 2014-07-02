#!/usr/bin/ruby

require "./Logger"
require "./Stopwatch"

module Main

	def Main.main()

		watch = Stopwatch.new
		Logger.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		Logger.info("$$$ START");
		Logger.info("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
		sleep(3.234);
		Logger.info("処理時間=[", watch.now, "]");
		Logger.info("$$$ END $$$");

	end

end

Main.main();


