#!/usr/bin/env ruby
# coding: utf-8


def _get_printer(stream)

	operation = lambda { |x|
		printf(stream, "%s\n", x)
	}
	return operation

end

def _main()

	printer = _get_printer(STDOUT)

	printer.call(1)
	printer.call(2)
	printer.call(3)
	printer.call(["あいうえお", "らりるれろ"])
	printer.call("Ok.")

end

_main()
