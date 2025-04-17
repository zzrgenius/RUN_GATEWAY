tar zxvf libserialport-0.1.2.tar.gz -C ./temp/
cd ./temp/libserialport-0.1.2
# ./configure --enable-tools=yes --host=aarch64-linux-gnu --prefix=--prefix=/home/zirun/work/RUN_GATEWAY/libs/
./configure --prefix=/home/zirun/work/RUN_GATEWAY/libs/
make 
make install
cd ../..
rm -rf ./temp/libserialport-0.1.2
