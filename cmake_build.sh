rm -rf build
mkdir build && cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../arm_gcc_toolchain.cmake -DCROSS_COMPILE=true -DCMAKE_C_COMPILER_WORKS=ON ..
#cmake ..
make && 
echo "build done"
pwd
if [ ! -f "./bin/fh_mqtt" ];then
    echo "cp to  /mnt/hgfs/imx_share/"    
    cp ../bin/fh_mqtt /mnt/hgfs/imx_share/
fi
