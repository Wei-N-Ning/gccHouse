#!/usr/bin/bash

# Source
# example:
# https://github.com/google/sanitizers/wiki/AddressSanitizer
# https://github.com/google/sanitizers/wiki/AddressSanitizerAndDebugger
# runtime error:
# https://github.com/google/sanitizers/issues/796
# solution is to use static linking

# see also:
# turn on sanitize in CMAKE
# https://gist.github.com/jlblancoc/44be9d4d466f0a973b1f3808a8e56782


CXX=${CXX:-g++}
DBG=${DBG:-gdb}

TEMPDIR=
setUp() {
    rm -rf /tmp/sut
    mkdir /tmp/sut
    TEMPDIR=/tmp/sut
}

sutbin=
buildSUT() {
    cat >${TEMPDIR}/_.cc <<"EOF"
int main() {
    int sut[16];
    sut[16] = 1;
    return 0;
}
EOF
    ${CXX} -std=c++14 -fsanitize=address -static-libasan \
${TEMPDIR}/_.cc \
-o ${TEMPDIR}/_
    sutbin=${TEMPDIR}/_
}

runSUT() {
    ${sutbin}
}

setUp
buildSUT
runSUT

