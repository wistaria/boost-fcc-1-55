#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION && \
 env BOOST_BUILD_PATH=. $PREFIX/bin/b2 -j4 -d2 --prefix=$PREFIX --layout=tagged --without-context --without-coroutine --without-python toolset=fccx threading=multi variant=release install) 2>&1 | tee build-install.log
