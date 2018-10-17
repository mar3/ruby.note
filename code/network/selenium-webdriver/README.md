# selenium-webdriver の動作メモ 

# chromedriver を設置 (Ubuntu 18 LTS, 2018-10-17)

`chromedriver_linux64.zip` を持ってきて PATH の範囲に置く。

# installing Google Chrome on (Ubuntu 18 LTS, 2018-10-17) 

```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
```

# [TROUBLESHOOTING] タイムアウト (Ubuntu 18 LTS, 2018-10-17)

タイムアウトします。

```
Traceback (most recent call last):
        9: from ./main.rb:33:in `<main>'
        8: from ./main.rb:8:in `_main'
        7: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver.rb:86:in `for'
        6: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/driver.rb:44:in `for'
        5: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/driver.rb:44:in `new'
        4: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/chrome/driver.rb:43:in `initialize'
        3: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/service.rb:69:in `start'
        2: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/socket_lock.rb:39:in `locked'
        1: from /var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/service.rb:72:in `block in start'
/var/lib/gems/2.5.0/gems/selenium-webdriver-3.14.1/lib/selenium/webdriver/common/service.rb:142:in `connect_until_stable': unable to connect to chromedriver 127.0.0.1:9515 (Selenium::WebDriver::Error::WebDriverError)
```

↓依存ライブラリを確認してみます。libgconf-2.so.4 が無いことがわかります。

```
nunuqn@instance-1:~/bin$ ldd chromedriver
        linux-vdso.so.1 (0x00007ffecf1fc000)
        libX11.so.6 => /usr/lib/x86_64-linux-gnu/libX11.so.6 (0x00007f32d9886000)
        librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007f32d967e000)
        libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f32d947a000)
        libgobject-2.0.so.0 => /usr/lib/x86_64-linux-gnu/libgobject-2.0.so.0 (0x00007f32d9226000)
        libglib-2.0.so.0 => /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0 (0x00007f32d8f10000)
        libXi.so.6 => /usr/lib/x86_64-linux-gnu/libXi.so.6 (0x00007f32d8d00000)
        libnss3.so => /usr/lib/x86_64-linux-gnu/libnss3.so (0x00007f32d89bc000)
        libnssutil3.so => /usr/lib/x86_64-linux-gnu/libnssutil3.so (0x00007f32d878d000)
        libsmime3.so => /usr/lib/x86_64-linux-gnu/libsmime3.so (0x00007f32d8561000)
        libplc4.so => /usr/lib/x86_64-linux-gnu/libplc4.so (0x00007f32d835c000)
        libnspr4.so => /usr/lib/x86_64-linux-gnu/libnspr4.so (0x00007f32d811f000)
        libgconf-2.so.4 => not found
        libstdc++.so.6 => /usr/lib/x86_64-linux-gnu/libstdc++.so.6 (0x00007f32d7d96000)
        libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007f32d79f8000)
        libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f32d77d9000)
        libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f32d73e8000)
        libxcb.so.1 => /usr/lib/x86_64-linux-gnu/libxcb.so.1 (0x00007f32d71c0000)
        /lib64/ld-linux-x86-64.so.2 (0x00007f32d9bbe000)
        libffi.so.6 => /usr/lib/x86_64-linux-gnu/libffi.so.6 (0x00007f32d6fb8000)
        libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007f32d6d46000)
        libXext.so.6 => /usr/lib/x86_64-linux-gnu/libXext.so.6 (0x00007f32d6b34000)
        libplds4.so => /usr/lib/x86_64-linux-gnu/libplds4.so (0x00007f32d6930000)
        libgcc_s.so.1 => /lib/x86_64-linux-gnu/libgcc_s.so.1 (0x00007f32d6718000)
        libXau.so.6 => /usr/lib/x86_64-linux-gnu/libXau.so.6 (0x00007f32d6514000)
        libXdmcp.so.6 => /usr/lib/x86_64-linux-gnu/libXdmcp.so.6 (0x00007f32d630e000)
        libbsd.so.0 => /lib/x86_64-linux-gnu/libbsd.so.0 (0x00007f32d60f9000)
```

対処方法

```
sudo apt install libgconf-2.4
```

