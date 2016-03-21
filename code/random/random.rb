#!/usr/bin/env ruby
# coding: utf-8

def _main()

	for i in 0..9

		text = printf("%03d", Random.rand(1000))
		puts text

	end

end

_main()
