#!/bin/bash
#--------------------------------------------------------------------------------
# MetTools - A Collection of Software for Meteorology and Remote Sensing
# Copyright (C) 2016  EUMETSAT
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#--------------------------------------------------------------------------------

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
export CXXFLAGS="-I${PREFIX}/include ${CXXFLAGS} -fPIC"
export LDFLAGS="-L${PREFIX}/lib $LDFLAGS"
export DYLD_LIBRARY_PATH="${PREFIX}/lib $DYLD_LIBRARY_PATH"

./configure --prefix=${PREFIX} \
    --with-pic \
    --disable-shared \
    --enable-static \
    --with-apr=${PREFIX}/bin/apr-1-config \
    --with-apr-util=${PREFIX}/bin/apu-1-config

make -j ${CPU_COUNT}
make install
