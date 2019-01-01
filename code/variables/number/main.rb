#!/usr/bin/env ruby
# coding: utf-8

def test_number(n)

	print("[INFO] [", n, "] > [", n.between?(100, 150), "]\n")

end

def main()

	test_number(-2)
	test_number(3.2983)
	test_number(12.3456)
	test_number(123)
	test_number(500)

end

main()
