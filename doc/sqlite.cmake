# Compile libsqlite
include(CheckLibraryExists)
include(ExternalProject)

if(BUILD_ONLY_DOCS)
  # skip
elseif(NOT BUILD_SQLITE_LIB)
  find_package(sqlite3 MODULE REQUIRED)
  message("Found libsqlite library: ${SQLite3_LIBRARIES}")
else()
  # Download and Compile SQLite3 library at compile time using ExternalProject
  # (e.g. when running `cmake --build` or `make`)
  set(LIBSQLITE_INSTALL_ROOT "${CMAKE_CURRENT_BINARY_DIR}/lib")
  set(LIBSQLITE_INSTALL_DIR "${LIBSQLITE_INSTALL_ROOT}/sqlite")

  if(BUILD_SHARED_LIBS)
    set(configure_args "--enable-shared" "--disable-static")
  else()
    set(configure_args "--enable-static" "--disable-shared")
  endif()

  if ("${CMAKE_GENERATOR}" MATCHES "Makefiles")
    set(MAKE_COMMAND "$(MAKE)") # recursive make (uses the same make as the main project)
  else()
    # just run make in a subprocess. We use single-process, but libmnl is a small project
    set(MAKE_COMMAND "make")
  endif ()

  if(BUILD_SHARED_LIBS)
    set(LIBSQLITE_LIB "${LIBSQLITE_INSTALL_DIR}/lib/libsqlite3.so")
    # add_library(SQLite::SQLite3 SHARED IMPORTED)
  else()
    set(LIBSQLITE_LIB "${LIBSQLITE_INSTALL_DIR}/lib/libsqlite3.a")
    # add_library(SQLite::SQLite3 STATIC IMPORTED)
  endif()

  message("Downloading and compiling our own libsqlite library")
  ExternalProject_Add(
    libsqlite
    # v3.31.01 is the version supported by OpenWRT 19.07 and Ubuntu 20.04
    # see https://github.com/openwrt/packages/blob/5a399f144891d6774611c9903f12059270b09ca8/libs/sqlite3/Makefile#L10-L11
    URL https://sqlite.org/2025/sqlite-autoconf-3490100.tar.gz
    URL_HASH SHA3_256=6cc831c9f588b637e5bd48d9fbf28e58737e08daf825c81085fb8e0a0b8ad14c  #106642d8ccb36c5f7323b64e4152e9b719f7c0215acf5bfeac3d5e7f97b59254
    DOWNLOAD_DIR ${CMAKE_SOURCE_DIR}/download # if empty string, uses default download dir
    INSTALL_DIR "${LIBSQLITE_INSTALL_DIR}"
    # CONFIGURE_COMMAND autoreconf -f -i -v <SOURCE_DIR>
    COMMAND
      ${CMAKE_COMMAND} -E env "PATH=$ENV{PATH}"
      <SOURCE_DIR>/configure --prefix=<INSTALL_DIR> "--host=${target_autoconf_triple}"
      # use position independent code, even for static lib, in case we want to make shared lib later
      --with-pic=on ${configure_args}
      "CC=${CMAKE_C_COMPILER}" "CFLAGS=${CMAKE_C_FLAGS}" "LDFLAGS=${CMAKE_SHARED_LINKER_FLAGS}"
    # need to manually specify PATH, so that make knows where to find cross-compiling GCC
    BUILD_COMMAND ${CMAKE_COMMAND} -E env "PATH=$ENV{PATH}" "${MAKE_COMMAND}"
    INSTALL_COMMAND ${CMAKE_COMMAND} -E env "PATH=$ENV{PATH}" "${MAKE_COMMAND}" install
    # technically this is an INSTALL_BYPRODUCT, but we only ever need this to make Ninja happy
    BUILD_BYPRODUCTS "${LIBSQLITE_LIB}"
  )
  ExternalProject_Get_Property(libsqlite INSTALL_DIR)

  set(sqlite_link_libs "pthread" "dl")

  # Some compilers don't have -lm since it's always linked by default
  CHECK_LIBRARY_EXISTS(m sin "" HAVE_LIB_M)
  if (HAVE_LIB_M)
    list(APPEND sqlite_link_libs "m")
  endif(HAVE_LIB_M)

  # folder might not yet exist if using ExternalProject_Add
  set(LIBSQLITE_INCLUDE_DIR "${LIBSQLITE_INSTALL_DIR}/include")
  file(MAKE_DIRECTORY "${LIBSQLITE_INCLUDE_DIR}")
  set(LIBSQLITE_LIB_DIR "${LIBSQLITE_INSTALL_DIR}/lib")

  # set_target_properties(SQLite::SQLite3 PROPERTIES
  #     IMPORTED_LOCATION "${LIBSQLITE_LIB}"
  #     INTERFACE_LINK_LIBRARIES "${sqlite_link_libs}"
  #     INTERFACE_INCLUDE_DIRECTORIES "${LIBSQLITE_INCLUDE_DIR}"
  # )

  # tell cmake that we can only use SQLite::SQLite3 after we compile it
  # add_dependencies(SQLite::SQLite3 libsqlite)
endif ()
