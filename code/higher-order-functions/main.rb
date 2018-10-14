#!/usr/bin/env ruby
# coding: utf-8
#

def _invoke(task, args)

	task.call(args)

end

def _main(argv)

	operation = lambda {|x|
		print('check: ', x * 2, "\n")
	}

	_invoke(operation, 5)

end

_main(ARGV)
