#!/usr/bin/env ruby
# coding: utf-8


def _main()

	STDIN.each do |line|

		line = line.rstrip
		if line == "" then
			next
		end

		items = line.split(",")
		print items

		print("\n")

	end

end

_main()
