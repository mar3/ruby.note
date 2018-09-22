# Getting Started with Rails on Ubuntu 18 LTS

```
sudo su - root
gem install rails
```


# ERROR: Failed to build gem native extension. (can't find header files for ruby at /usr/lib/ruby/include/ruby.h)

Problem is

```
root@instance-1:~# gem install rails
Building native extensions. This could take a while...
ERROR:  Error installing rails:
        ERROR: Failed to build gem native extension.

    current directory: /var/lib/gems/2.5.0/gems/nokogiri-1.8.4/ext/nokogiri
/usr/bin/ruby2.5 -r ./siteconf20180922-2893-hs76pw.rb extconf.rb
mkmf.rb can't find header files for ruby at /usr/lib/ruby/include/ruby.h

extconf failed, exit code 1

Gem files will remain installed in /var/lib/gems/2.5.0/gems/nokogiri-1.8.4 for inspection.
Results logged to /var/lib/gems/2.5.0/extensions/x86_64-linux/2.5.0/nokogiri-1.8.4/gem_make.out
```

Install ruby-dev.

```
sudo su - root
apr install ruby-dev
```





# ERROR: Failed to build gem native extension. (You have to install development tools first.)

Problem is

```
root@instance-1:~# gem install rails
Building native extensions. This could take a while...
ERROR:  Error installing rails:
        ERROR: Failed to build gem native extension.

    current directory: /var/lib/gems/2.5.0/gems/nokogiri-1.8.4/ext/nokogiri
/usr/bin/ruby2.5 -r ./siteconf20180922-3178-sd2ch.rb extconf.rb
checking if the C compiler accepts ... *** extconf.rb failed ***
Could not create Makefile due to some reason, probably lack of necessary
libraries and/or headers.  Check the mkmf.log file for more details.  You may
need configuration options.

Provided configuration options:
        --with-opt-dir
        --without-opt-dir
        --with-opt-include
        --without-opt-include=${opt-dir}/include
        --with-opt-lib
        --without-opt-lib=${opt-dir}/lib
        --with-make-prog
        --without-make-prog
        --srcdir=.
        --curdir
        --ruby=/usr/bin/$(RUBY_BASE_NAME)2.5
        --help
        --clean
/usr/lib/ruby/2.5.0/mkmf.rb:456:in `try_do': The compiler failed to generate an executable file. (RuntimeError)
You have to install development tools first.
        from /usr/lib/ruby/2.5.0/mkmf.rb:574:in `block in try_compile'
        from /usr/lib/ruby/2.5.0/mkmf.rb:521:in `with_werror'
        from /usr/lib/ruby/2.5.0/mkmf.rb:574:in `try_compile'
        from extconf.rb:138:in `nokogiri_try_compile'
        from extconf.rb:162:in `block in add_cflags'
        from /usr/lib/ruby/2.5.0/mkmf.rb:632:in `with_cflags'
        from extconf.rb:161:in `add_cflags'
        from extconf.rb:410:in `<main>'

To see why this extension failed to compile, please check the mkmf.log which can be found here:

  /var/lib/gems/2.5.0/extensions/x86_64-linux/2.5.0/nokogiri-1.8.4/mkmf.log

extconf failed, exit code 1

Gem files will remain installed in /var/lib/gems/2.5.0/gems/nokogiri-1.8.4 for inspection.
Results logged to /var/lib/gems/2.5.0/extensions/x86_64-linux/2.5.0/nokogiri-1.8.4/gem_make.out
```


```
sudo su - root
apt install g++
```


