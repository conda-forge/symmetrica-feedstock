#!/bin/bash

rm makefile
cp $RECIPE_DIR/CMakeLists.txt .

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_POSITION_INDEPENDENT_CODE=yes \
    -DBUILD_SHARED_LIBS=yes \
..

make -j${CPU_COUNT}
make install

ctest
