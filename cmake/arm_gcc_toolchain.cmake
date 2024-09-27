##################################
# 配置ARM交叉编译
#################################
set(CMAKE_SYSTEM_NAME Linux)    #设置目标系统名字
set(CMAKE_SYSTEM_PROCESSOR arm) #设置目标处理器架构
 
set(tools /home/zirun/scu/cross_compile/gcc-linaro-4.9)
if(UNIX)
   if(CROSS_COMPILE)
     message(STATUS "CROSS_COMPILE:${CROSS_COMPILE}")
      SET(CMAKE_SYSTEM_NAME Linux)
      SET(CMAKE_SYSTEM_PROCESSOR arm)
      SET(TOOLCHAIN_DIR "$ENV{HOME}/scu/cross_compile/gcc-linaro-4.9")
      set(CMAKE_C_COMPILER "${TOOLCHAIN_DIR}/bin/arm-linux-gnueabihf-gcc")
      set(CMAKE_CXX_COMPILER "${TOOLCHAIN_DIR}/bin/arm-linux-gnueabihf-g++")
      set(CMAKE_LINKER "${TOOLCHAIN_DIR}/bin/arm-linux-gnueabihf-g++")
      set(CMAKE_SYSROOT "${TOOLCHAIN_DIR}/arm-linux-gnueabihf/libc")
      set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
      set(CMAKE_C_FLAGS"${CMAKE_C_FLAGS} --sysroot=${TOOLCHAIN_DIR}/arm-linux-gnueabihf/libc")
   elseif (EXISTS "$ENV{HOME}/local/bin/gcc")
      set(CMAKE_C_COMPILER "$ENV{HOME}/local/bin/gcc")
      set(CMAKE_CXX_COMPILER "$ENV{HOME}/local/bin/g++")
      set(CMAKE_LINKER "$ENV{HOME}/local/bin/g++")
   elseif (EXISTS "/usr/local/bin/gcc")
      set(CMAKE_C_COMPILER /usr/local/bin/gcc)
      set(CMAKE_CXX_COMPILER /usr/local/bin/g++)
      set(CMAKE_LINKER /usr/local/bin/g++)
   endif()
endif()

message(STATUS "CMAKE_C_COMPILER is : ${CMAKE_C_COMPILER}")
message(STATUS "CMAKE_CXX_COMPILER is : ${CMAKE_CXX_COMPILER}")


set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

#################################
# end
##################################
