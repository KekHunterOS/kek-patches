#!/bin/bash

#
# This whole template is taken from https://github.com/Halium/hybris-patches/blob/halium-9.0
#

set -e

MB=$1

USE_PATCH=0
if [ "$MB" != "--mb" ]; then
    USE_PATCH=1
fi

OLD_WD=`pwd`
cd kek-patches

if [ "$USE_PATCH" == "1" ]; then
    for patch in `find . -name *.patch |sort`; do
        cd $OLD_WD/$(dirname $patch)
        patch -p1 < $OLD_WD/kek-patches/$patch
    done
else
    MBS=$(find . -name *.patch -exec dirname {} \; |sort -u)
    for mb in $MBS; do
        cd $OLD_WD/$mb
        git am --no-gpg-sign $OLD_WD/kek-patches/$mb/*.patch
    done
fi

