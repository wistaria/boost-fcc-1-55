#!/bin/sh

SRC_DIR=$(dirname $0)
. $SRC_DIR/version.sh

(cd $SRC_DIR/boost_$BOOST_VERSION && \
 echo "using mpi : $(which mpiFCCpx) ;" > tools/build/v2/user-config.jam && \
 env BOOST_BUILD_PATH=. $PREFIX/bin/b2 -j4 -d2 --prefix=$PREFIX --layout=tagged --without-context --without-coroutine --without-python toolset=fccx threading=multi variant=release stage) 2>&1 | tee build-stage.log
cp -rp build-stage.log $SRC_DIR/boost_$BOOST_VERSION/build.log

DIRS=$(cd $SRC_DIR/boost_$BOOST_VERSION/bin.v2/libs && ls)
echo "(cd $SRC_DIR/boost_$BOOST_VERSION && grep FCCpx build.log | grep '\-shared' | \\" > fix-stage.sh
for d in $DIRS; do
  echo "sed 's#bin.v2/libs/$d/build/fccx/release/threading-multi/libboost#libboost#' | \\" >> fix-stage.sh
done
echo "sed 's#bin.v2/libs/log/build/fccx/release/build-no/log-api-unix/threading-multi/libboost#libboost#' | \\" >> fix-stage.sh
echo "sh -x)" >> fix-stage.sh
echo "Fixing shared library search path..." | tee -a build-stage.log
sh fix-stage.sh | tee -a build-stage.log
mv -f $SRC_DIR/boost_$BOOST_VERSION/libboost* $SRC_DIR/boost_$BOOST_VERSION/stage/lib/
(cd $SRC_DIR/boost_$BOOST_VERSION && grep '^    cp' build.log | grep 'release/threading-multi' | awk '{print $1,$3,$2}' | sh -x) | tee -a build-stage.log
