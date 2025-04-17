tar zxvf zlog-1.2.18.tar.gz -C ./temp/
cd ./temp/zlog-1.2.18
make PREFIX=/home/zirun/work/RUN_GATEWAY/libs/
make PREFIX=/home/zirun/work/RUN_GATEWAY/libs/ install
cd ../..
rm -rf ./temp/zlog-1.2.18
