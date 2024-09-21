# RUN_GATEWAY
自定义网关，基于Linux

# some libs
	libuv
	nng
	libmodbus
	libiec61850
	zlog
	[zlog](https://github.com/HardySimpson/zlog.git)
	```shell
	$ git clone -b 1.2.15 https://github.com/HardySimpson/zlog.git
	$ cd zlog
	$ make && sudo make install

	[sqlite](https://github.com/sqlite/sqlite)
	```shell
	$ curl -o sqlite3.tar.gz https://www.sqlite.org/2022/sqlite-autoconf-3390000.tar.gz
	$ mkdir sqlite3
	$ tar xzf sqlite3.tar.gz --strip-components=1 -C sqlite3
	$ cd sqlite3
	$ ./configure CFLAGS=-fPIC && make && sudo make install
