#!/bin/bash

if [ $(uname) == Linux ]; then
    ar vx pandoc*.deb
    tar -xzvf data.tar.gz
    mkdir -p $PREFIX/bin
    mv usr/bin/* $PREFIX/bin
fi

# TODO :: The * here is because of a conda-build bug where
# TODO :: the hash gets added. ca-certificates suffers too
if [ $(uname) == Darwin ]; then
    pkgutil --expand pandoc-${PKG_VERSION}*.pkg pandoc
    cpio -i -I pandoc/pandoc.pkg/Payload
    mkdir -p $PREFIX/bin
    cp usr/local/bin/* $PREFIX/bin/
fi
