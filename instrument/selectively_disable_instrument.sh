#!/usr/bin/env bash

# use case:

# I want to instrument ALL the functions except for one 
# I need to mark this special one "no_instrument_function"

# source
# NOTE: I haven't found a single article that explains this concept
# well enough....
# https://gcc.gnu.org/onlinedocs/gcc-6.3.0/gcc/Instrumentation-Options.html
# https://gcc.gnu.org/onlinedocs/gcc-4.6.0/gcc/i386-and-x86_002d64-Options.html#i386-and-x86_002d64-Options
# https://gcc.gnu.org/onlinedocs/gcc/x86-Function-Attributes.html#x86-Function-Attributes
# https://gcc.gnu.org/onlinedocs/gcc/Attribute-Syntax.html
# https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#Common-Function-Attributes
# https://gcc.gnu.org/onlinedocs/gcc-5.2.0/gcc/Label-Attributes.html
# https://stackoverflow.com/questions/44978546/is-it-possible-to-use-gcc-to-compile-one-section-of-a-code-file-with-specific-co
# 

CC=${CC:-gcc}
CXX=${CXX:-g++}
DBG=${DBG:-gdb}

set -e

TEMPDIR=/tmp/sut

tearDown() {
    rm -rf ${TEMPDIR}
}

setUp() {
    tearDown
    mkdir -p ${TEMPDIR}
}

# $1: addition cxxflags
SUTBIN=
generateSUT() {
    cat >${TEMPDIR}/_.c <<"EOF"   
__attribute__((no_instrument_function)) 
void foo() {
}

void bar() {
}

int main() {
    foo();
    bar();
    return 0;
}
EOF
    ${CC} ${1} -finstrument-functions ${TEMPDIR}/_.c -o ${TEMPDIR}/_
    SUTBIN=${TEMPDIR}/_ 
}

verifySUT() {
    echo '//////// verify ////////'
    cat >${TEMPDIR}/commands.gdb <<"EOF"
start
rb __cyg_profile_func_enter$
continue
bt
EOF
    ${DBG} -batch -quiet -command=${TEMPDIR}/commands.gdb ${SUTBIN} 2>/dev/null
}

disassembleSUT() {
    ${DBG} -batch -quiet \
-ex "file ${TEMPDIR}/_" \
-ex "set disassembly-flavor intel" \
-ex "disassemble /rs main"
}

setUp

generateSUT "-g"
verifySUT

# compile with aggressive optimization flag
# bar() is inlined but the hooks are still added to main()
generateSUT "-g -O3"
verifySUT
disassembleSUT

tearDown


