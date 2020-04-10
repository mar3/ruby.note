#!/usr/bin/env ruby

module CommonOperations
	def CommonOperations.operation1()
		puts "$$$ Hello! $$$"
	end
end

module MyModule
	include CommonOperations
	def MyModule.run
		CommonOperations.operation1
	end
end

class Main
	def main()
		puts("### start ###")
		MyModule.run
		puts("--- end ---")
	end
end

Main.new.main()
