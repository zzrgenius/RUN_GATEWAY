cmake_minimum_required(VERSION 3.16.0)

project(hello_world         
VERSION 0.1.0
LANGUAGES C
)
 
set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g2 -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")

option(BUILD_SQLITE_LIB "Build sqlite3 library" ON)
include(${CMAKE_CURRENT_LIST_DIR}/libs/sqlite.cmake)

# include(FetchContent)
# FetchContent_Declare(sqlite3 GIT_REPOSITORY https://github.com/sjinks/sqlite3-cmake GIT_TAG v3.49.1)
# FetchContent_MakeAvailable(sqlite3)

 ##aux_source_directory(${TINY_ROOT}/core CORE_SRCS)

# file(MAKE_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/sqlite-build)

include_directories(./)
include_directories(./inc)

set(APP_SRCS src/main.c)
add_library(linenoise SHARED third_party/linenoise/linenoise.h third_party/linenoise/linenoise.c)
add_executable(hello_world ${APP_SRCS} )

# ExternalProject_Add(sqlite
# 		SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/sqlite
# 		BINARY_DIR ${CMAKE_CURRENT_LIST_DIR}/sqlite-build
# 		CONFIGURE_HANDLED_BY_BUILD true
# 		CONFIGURE_COMMAND <SOURCE_DIR>/configure
# 		BUILD_COMMAND ${MAKE_EXECUTABLE}
# 		INSTALL_COMMAND ${MAKE_EXECUTABLE} DESDIR=<BINARY_DIR> prefix=<BINARY_DIR> TCLLIBDIR=<BINARY_DIR>/usr/share/tcltk/tcl8.6/sqlite3 install
# 		TEST_COMMAND cmake -E echo "Skipping test step."
# 		# "Need to specify main libraries that are built so ninja knows to look for them."
# 		# Not sure if this is necessary or not.
# 		BUILD_BYPRODUCTS <BINARY_DIR>/lib/libsqlite3.a <BINARY_DIR>/lib/libsqlite3.so
# ) 
 

target_link_libraries(hello_world pthread linenoise) 