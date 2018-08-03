#!/usr/bin/env bash

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

