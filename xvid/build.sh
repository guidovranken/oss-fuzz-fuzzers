#!/bin/bash

set -e

svn checkout http://svn.xvid.org/trunk --username anonymous --password "" --non-interactive --no-auth-cache
git clone --depth 1 https://github.com/guidovranken/fuzzing-headers.git
git clone --depth 1 https://github.com/guidovranken/oss-fuzz-fuzzers.git

export FUZZING_HEADERS=`realpath fuzzing-headers`
export OSS_FUZZ_FUZZERS=`realpath oss-fuzz-fuzzers`

export CC=clang
export CXX=clang++
export CFLAGS="-fsanitize=fuzzer-no-link,address,undefined -fno-common -g -O0"
export CXXFLAGS="-fsanitize=fuzzer-no-link,address,undefined -fno-common -g -O0"

mkdir xvid-install
export XVID_INSTALL_PATH=`realpath xvid-install`

cd trunk/xvidcore/build/generic/

./bootstrap.sh
./configure --prefix=$XVID_INSTALL_PATH
make -j$(nproc)
make install

mkdir -p $XVID_INSTALL_PATH/bin/
$CXX $CXXFLAGS -I $XVID_INSTALL_PATH/include -I $FUZZING_HEADERS/include -fsanitize=fuzzer $OSS_FUZZ_FUZZERS/xvid/fuzzer.cpp $XVID_INSTALL_PATH/lib/libxvidcore.a -o $XVID_INSTALL_PATH/bin/fuzzer-decoder
