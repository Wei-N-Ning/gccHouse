#!/usr/bin/env bash

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

generateSUT() {
    echo "
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
" >/tmp/sut.cpp
}

generateSUT

g++ -std=c++11 -finstrument-functions /tmp/sut.cpp -o /tmp/_

