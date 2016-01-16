#!/usr/bin/env ruby
# coding: utf-8

require 'digest/sha1'

def _main(args)

	e = 'abcdefg'
	if 1 <= args.count
		e = args[0]
	end

	print Digest::SHA1.hexdigest(e)
	print "\n"

end

_main(ARGV)

