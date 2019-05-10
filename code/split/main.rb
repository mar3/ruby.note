#!/usr/bin/env ruby
# coding: utf-8

def test(s)

	if s == nil
		print('[TRACE] (nil)', "\n")
		return
	end
	values = s.split()
	print('[TRACE] ')
	p values

end

def main()

	test('abc')
	test(nil)
	test('')
	test('aaa bbb ccc     ')
	test('東京都　三郷市　栃木県　　　　本町')

end

main()

