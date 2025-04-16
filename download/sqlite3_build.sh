tar zxvf sqlite-autoconf-3490100.tar.gz -C ./temp/
cd ./temp/sqlite-autoconf-3490100
# ./configure --prefix=/usr/local/sqlite3  --host=arm-linux-gnu
./configure --prefix=/home/zirun/work/RUN_GATEWAY/libs/
make
make install
cd ../..
rm -rf ./temp/sqlite-autoconf-3490100
