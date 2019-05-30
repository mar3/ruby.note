#!/usr/bin/env ruby



def main()

	items = ["", nil, "a", nil, "b", "", "", "c", ""]
	pp items.compact()
	pp items.compact().reject(&:empty?)

end

main()

