#!/usr/bin/env ruby
# coding: utf-8

def _println(*args)

	print(*args)
	print("\n")

end

def _enum_items()

	items = [1, 'レレレ', '東京都千代田区大手町 1-1']
	items.push('ジミ ヘンドリックス')
	return items

end

def _main()

	items = _enum_items()

	_println('### init ###')
	_println('item is: [', items.class, ']')
	_println()

	_println('### print ###')
	_println('items are: ', items, ', size is: ', items.size)
	_println('items[0] is: ', items[0])
	_println('items[1] is: ', items[1])
	_println('items[2] is: ', items[2])
	_println('items[3] is: ', items[3])
	_println('items[4] is: ', items[4])
	_println()

	_println('### puts ###')
	puts(items)
	_println()

end

_main()
