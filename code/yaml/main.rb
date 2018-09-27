#!/usr/bin/env ruby
# coding: utf-8

require 'yaml'

def _configure()

	print("[info] $$$ _configure() $$$\n")

	begin
		conf = YAML.load_file("settings.yam")
		return conf
	rescue => e
		print("[error] ", e, "\n")
		return nil
	end

end

def _run()

	conf = _configure()
	if conf == nil then
		return
	end

	print("service_name: [", conf["settings"]["database"]["service_name"], "]", "\n")
	print("user: [", conf["settings"]["database"]["user"], "]", "\n")
	print("undefined-key: [", conf["settings"]["database"]["undefined-key"], "]", "\n")

end

def _main()

	print("[info] ### start ###\n")

	_run()

	print("[info] --- end ---\n")

end

_main()
