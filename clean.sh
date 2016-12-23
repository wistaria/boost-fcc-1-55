#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION/tools/build/v2 && \
 rm -rf b2 bjam bin bootstrap.log engine/bin.* engine/bootstrap)
(cd $SRC_DIR/boost_$BOOST_VERSION && \
 rm -rf bin.v2 stage tools/build/v2/user-config.jam && \
 touch tools/build/v2/user-config.jam)
rm -f build-*.log fix-stage.sh
