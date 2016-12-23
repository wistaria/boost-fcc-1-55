#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION/tools/build/v2 && \
 rm -rf b2 bjam bin bootstrap.log engine/bin.* engine/bootstrap)
(cd $SRC_DIR/boost_$BOOST_VERSION && \
 rm -rf bin.v2 stage user-config.jam)
(cd $SRC_DIR && \
 rm -f build-*.log)
