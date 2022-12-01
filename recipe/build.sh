#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# The pandoc binary for arm64 is in /usr/bin
if [[ ${target_platform} =~ .*linux-aarch64.* ]]; then
    cd usr/
fi

mkdir -p ${PREFIX}/bin
mv bin/* ${PREFIX}/bin

if [[ ${target_platform} =~ .*linux-s390x.* ]]; then
  mkdir -p ${PREFIX}/share
  mkdir -p ${PREFIX}/lib
  cp -r common/share/* ${PREFIX}/share
  cp -r cmark/lib64/* ${PREFIX}/lib
  mv ${PREFIX}/bin/pandoc.static ${PREFIX}/bin/pandoc
fi

# The pandoc binary was built against libffi 3.2 but is compatible with 3.3 which uses a different SONAME
if [[ ${target_platform} =~ .*linux-ppc64le.* ]]; then
    patchelf --replace-needed libffi.so.6 libffi.so.7  ${PREFIX}/bin/pandoc
fi
if [[ ${target_platform} =~ .*linux-s390x.* ]]; then
    patchelf --replace-needed libffi.so.8 libffi.so.7  ${PREFIX}/bin/pandoc
    patchelf --replace-needed libffi.so.6 libffi.so.7  ${PREFIX}/bin/pandoc
fi

