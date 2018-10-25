#!/bin/sh

BROTLI_SRC=https://github.com/google/brotli/archive/v1.0.7.tar.gz

# Build Brotli with Autotools-style CMake

cd /tmp && \
wget -qO - $BROTLI_SRC | tar xz -f '-' && \
cd brotli* && \
mkdir out && cd out && \
../configure-cmake --disable-debug && \
make && make install
