#!/usr/bin/env ruby

def test1
	begin
		# causes "Key not found"
		xxx = ENV.fetch("XXX")
		print("[TRACE] XXX: [", xxx, "]", "\n")
	rescue => e
		print("[ERROR] ", e, "\n")
	end
end

def test2
	begin
		# xxx is nil
		xxx = ENV["XXX"]
		print("[TRACE] XXX: [", xxx, "]", "\n")
	rescue => e
		print("[ERROR] ", e, "\n")
	end
end

def main
	test1
	test2
end

main
