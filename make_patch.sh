#!/bin/sh

BOOST_VERSION=1_55_0

git diff --no-prefix -r import_$BOOST_VERSION boost_$BOOST_VERSION > boost_${BOOST_VERSION}.patch
