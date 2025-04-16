tar zxvf libmodbus-3.1.11.tar.gz -C ./temp/
cd ./temp/libmodbus-3.1.11
./configure --enable-static --prefix=/home/zirun/work/RUN_GATEWAY/libs/
# ./configure --enable-static --prefix=/home/zirun/work/RUN_GATEWAY/libs/libmodbus  --host=arm-linux-gnu
make
make install
cd ../..
rm -rf ./temp/libmodbus-3.1.11
