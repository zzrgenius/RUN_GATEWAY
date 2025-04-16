tar zxvf libuv-1.50.0.tar.gz -C ./temp/
cd ./temp/libuv-1.50.0
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF -DCMAKE_INSTALL_PREFIX=/home/zirun/work/RUN_GATEWAY/libs/ ..
# cmake  -DCMAKE_TOOLCHAIN_FILE=../aarch64.cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/zirun/work/RUN_GATEWAY/libs/ ..
make
make install
cd ../../..
rm -rf ./temp/libuv-1.50.0
