#!/bin/bash

rm makefile
cp $RECIPE_DIR/CMakeLists.txt .

if [[ "$target_platform" == "linux-ppc64le" ]]; then
  export CXX=clang++
  export CC=clang
fi

CFLAGS=$(echo "${CFLAGS}" | sed "s/-mpower8-fusion//g")
CFLAGS=$(echo "${CFLAGS}" | sed "s/-mpower8-vector//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-mpower8-fusion//g")
CXXFLAGS=$(echo "${CXXFLAGS}" | sed "s/-mpower8-vector//g")

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=yes \
    -DBUILD_SHARED_LIBS=yes \
    -DCMAKE_INSTALL_LIBDIR=lib \
..

make -j${CPU_COUNT}
make install

ctest
