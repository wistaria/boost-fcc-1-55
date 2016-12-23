#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION/tools/build/v2 && \
 sh bootstrap.sh && \
 ./b2 --prefix=$PREFIX toolset=gcc install) | tee build-bjam.log
