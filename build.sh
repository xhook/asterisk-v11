#!/bin/bash

if [ -z "$1" ]
then
  echo "Usage: $0 <install_path> [debug]"
  exit 1
fi

CFLAGS="-O2 -mtune=generic -fPIC"
if [ "$2" == "debug" ]; then
  ENABLE_DEV_MODE="--enable-dev-mode"
  CFLAGS="-O0 -g -fPIC"
fi

cd ./third_party/opus
./build.sh || exit 1
cd ../..

export INSTALL_DIR=$1
LDFLAGS="-Wl,-rpath,this_rpath_will_be_rplaced_by_chrpath_tool" CFLAGS=$CFLAGS CXXFLAGS=$CFLAGS \
  ./configure \
    $ENABLE_DEV_MODE \
    --prefix=$INSTALL_DIR \
    --disable-xmldoc \
    --with-crypto \
    --with-ssl \
    --with-srtp \
    --with-opus=$PWD/third_party/opus/build &&
  make && 
  make install &&
  chrpath -r '$ORIGIN/../lib' $INSTALL_DIR/sbin/asterisk

cd ./third_party/appkonference
./build.sh \
  $INSTALL_DIR \
  $PWD/../.. \
cd ../..

# Cleanuo MOH
rm $INSTALL_DIR/var/lib/asterisk/moh/flame.wav
rm $INSTALL_DIR/var/lib/asterisk/moh/macroform-cold_day.wav
rm $INSTALL_DIR/var/lib/asterisk/moh/macroform-robot_dity.wav
rm $INSTALL_DIR/var/lib/asterisk/moh/manolo_camp-morning_coffee.wav
rm $INSTALL_DIR/var/lib/asterisk/moh/reno_project-system.wav
