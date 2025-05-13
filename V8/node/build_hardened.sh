#!/bin/bash
export CC=clang-14
export CXX=clang++-14
export CFLAGS="-fPIE -fstack-protector-strong -fsanitize=cfi -fsanitize=safe-stack"
export CXXFLAGS="-fPIE -fstack-protector-strong -fsanitize=cfi -fsanitize=safe-stack"
export LDFLAGS="-pie"
./configure \
  --ninja \
  --prefix=/usr/local/node-hardened \
  --enable-seccomp \
  --experimental-enable-heap-protection
make -j$(nproc)
sudo make install
