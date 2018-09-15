#!/bin/bash

if [[ `uname` == MINGW* ]]; then
    export CC=clang-cl
    export RANLIB=llvm-ranlib
    export LINK=lld-link
    export AR=llvm-ar
    export PATH="$PREFIX/Library/bin:$BUILD_PREFIX/Library/bin:$PATH"
else
    export RANLIB=ranlib
    export AR=ar
    export LINK=ld
fi

export CFLAGS="-O2 -g $CFLAGS -fPIC -DFAST -DALLTRUE"

cp "$RECIPE_DIR"/patches/makefile .
 
make RANLIB=$RANLIB AR=$AR LINK=$LINK CC=$CC
make test

actual=`echo 123 | ./test`
expected=" 12.146304.367025.329675.766243.241881.295855.454217.088483.382315.
 328918.161829.235892.362167.668831.156960.612640.202170.735835.221294.
 047782.591091.570411.651472.186029.519906.261646.730733.907419.814952.
 960000.000000.000000.000000.000000 "

if [ "$actual" != "$expected" ]; then
    exit 1
fi


if [[ `uname` == MINGW* ]]; then
    mkdir -p "$PREFIX"/Library/lib
    cp libsymmetrica.a "$PREFIX"/Library/lib/symmetrica.lib
    mkdir -p "$PREFIX"/Library/include/symmetrica
    cp *.h "$PREFIX"/Library/include/symmetrica/
else
    mkdir -p "$PREFIX"/lib
    cp libsymmetrica.a "$PREFIX"/lib/
    mkdir -p "$PREFIX"/include/symmetrica
    cp *.h "$PREFIX"/include/symmetrica/
fi
