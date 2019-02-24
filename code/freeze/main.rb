#!/usr/bin/env ruby
# coding: utf-8

def enum_soft_shops
	shops = ["aaa", "bbb", "ccc"]
	return shops
end

def enum_hard_shops()
	shops = ["aaa", "bbb", "ccc"].freeze()
	return shops
end

def main()

	begin
		soft_shops = enum_soft_shops()
		soft_shops.append("燃えよドラゴン")
		print("[TRACE] ", soft_shops, "\n")
	rescue => ex
		print("[ERROR] ", ex, "\n")
	end

	begin
		hard_shops = enum_hard_shops()
		hard_shops.append("ddd")
		print("[TRACE] ", hard_shops, "\n")
	rescue => ex
		print("[ERROR] ", ex, "\n")
	end

	print("[TRACE] Ok.\n")

end

main()

