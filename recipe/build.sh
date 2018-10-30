#!/bin/bash

set -x -e

INCLUDE_PATH="${PREFIX}/include"
LIBRARY_PATH="${PREFIX}/lib $LIBRARY_PATH"

if [ "$(uname)" == "Darwin" ]; then
    TOOLSET=clang
    CC=clang
    CXX=clang++
elif [ "$(uname)" == "Linux" ]; then
    TOOLSET=gcc
fi

export CPPFLAGS="-I${PREFIX}/include ${CPPFLAGS} -fPIC"
export CFLAGS="-I${PREFIX}/include ${CFLAGS} -fPIC"
export CXXFLAGS="-I${PREFIX}/include ${CXXFLAGS} -fPIC -std=c++14 -D_GLIBCXX_USE_CXX11_ABI=0"
export LDFLAGS="-L${PREFIX}/lib $LDFLAGS"
export DYLD_LIBRARY_PATH=${PREFIX}/lib

./configure --prefix=${PREFIX} \
    --with-pic \
    --with-apr=${PREFIX}/bin/apr-1-config \
    --with-apr-util=${PREFIX}/bin/apu-1-config

make -j ${CPU_COUNT}
make install
