#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION && \
 echo "using mpi : $(which mpiFCCpx) ;" > user-config.jam && \
 env BOOST_BUILD_PATH=. $PREFIX_FRONTEND/bin/b2 -d2 --prefix=$PREFIX --layout=tagged --without-context --without-coroutine --without-python toolset=fccx threading=multi variant=release stage) | tee build-stage.log
