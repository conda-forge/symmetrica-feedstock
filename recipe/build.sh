#!/bin/bash

cp $RECIPE_DIR/CMakeLists.txt .

if [[ "$target_platform" == "linux-ppc64le" ]]; then
  export CXX=clang++
  export CC=clang
fi

mkdir build
cd build
cmake ${CMAKE_ARGS} -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=yes \
    -DBUILD_SHARED_LIBS=yes \
    -DCMAKE_INSTALL_LIBDIR=lib \
..

make -j${CPU_COUNT}
make install

if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
ctest
fi
