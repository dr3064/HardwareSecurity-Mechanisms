#!/bin/bash
./configure \
  --ninja \
  --prefix=/usr/local/node-vanilla
make -j$(nproc)
sudo make install
