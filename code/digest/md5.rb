#!/usr/bin/env ruby
# coding: utf-8

require 'digest/md5'

def _main(args)

	e = 'abcdefg'
	if 1 <= args.count
		e = args[0]
	end

	print Digest::MD5.hexdigest(e)
	print "\n"

end

_main(ARGV)

