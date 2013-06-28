#!/bin/bash
CFLAGS="-g -O2 -mtune=generic" ./configure \
  --disable-silent-rules \
  --enable-shared=no \
  --with-pic=yes \
  --prefix=$PWD/build && 
make && 
make install

