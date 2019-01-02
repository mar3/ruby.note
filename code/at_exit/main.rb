#!/usr/bin/env ruby

def exit_handler()

	print("<", __method__, "> $$$ begin $$$", "\n")
	print("<", __method__, "> --- end ---", "\n")

end

def main()

	Kernel.at_exit do exit_handler() end
	print("<", __method__, "> ### START ###", "\n")
	print("<", __method__, "> --- END ---", "\n")

end

main()

