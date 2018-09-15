#!/bin/bash

CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Release"

if [[ `uname` == MINGW* ]]; then
    export CC=clang-cl
    export RANLIB=llvm-ranlib
    export AR=llvm-ar
    export PATH="$PREFIX/Library/bin:$BUILD_PREFIX/Library/bin:$PATH"
    CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=$PREFIX/Library"
else
    CMAKE_ARGS="$CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_POSITION_INDEPENDENT_CODE=yes"
fi

rm makefile
cp "$RECIPE_DIR"/CMakeLists.txt .

cmake -G "Ninja" $CMAKE_ARGS .
ninja -j${CPU_COUNT}
ninja install

actual=`echo 123 | ./test`
expected=" 12.146304.367025.329675.766243.241881.295855.454217.088483.382315.
 328918.161829.235892.362167.668831.156960.612640.202170.735835.221294.
 047782.591091.570411.651472.186029.519906.261646.730733.907419.814952.
 960000.000000.000000.000000.000000 "

if [ "$actual" != "$expected" ]; then
    exit 1
fi
