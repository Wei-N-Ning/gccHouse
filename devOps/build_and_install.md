
# download

gcc source can be downloaded as a single tar or from its github mirror

# build

source:
```
https://gcc.gnu.org/wiki/InstallingGCC
https://gcc.gnu.org/wiki/FAQ#configure
```

do:
```
cd gcc_git_repo
./contrib/download_prerequisities
cd ..
mkdir gcc-build
cd gcc-build
../gcc/configure --prefx=somewhere --enable-languages=c,c++
make
```

this creates xgcc and xg++


