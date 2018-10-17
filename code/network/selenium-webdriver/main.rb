#!/usr/bin/env ruby
# coding: utf-8
# It was ran at Ubuntu 18 LTS on GCE.

require 'selenium-webdriver'

def _open_bak()

	# デスクトップマシンならこれでよさそう
	return Selenium::WebDriver.for :chrome

end

def _open()

	# Ubuntu Server(画面なし) の場合
	chrome_options = {binary: "/usr/bin/google-chrome", args: ["--headless"]}
	caps = Selenium::WebDriver::Remote::Capabilities.chrome('chromeOptions' => chrome_options)
	return Selenium::WebDriver.for :chrome, desired_capabilities: caps

end
	
def _main()

	session = _open()
	session.manage.timeouts.implicit_wait = 600
	url = 'https://www.yahoo.co.jp'
	session.navigate.to(url)
	print(session.title, "\n")
	session.manage.window.resize_to(1024, 4096)
	session.save_screenshot('screenshot.png')
	session.quit

end

_main()
