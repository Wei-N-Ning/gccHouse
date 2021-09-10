# Install GCC 11.2 on Ubuntu 20

## Download

download the tar ball from the github mirror (tags page)

untar then make a `build` subdirectory

## Install ALL THE PREREQUISITES

there are a lot of prerequisites to install; missing any of them
will result in compilation failure

### Use the download script from gcc repo

at the repo root, run `./contrib/download_prerequisites`

this will download the libraries that are picked up by the
build process.

### Install packages

install these packages, as per this page:
<https://gcc.gnu.org/install/prerequisites.html>

```shell
sudo apt install flex gperf gettext autogen texinfo \
    diffutils binutils ssh \
    python3-sphinx \
    guile-3.0 \
    expect \
    autogen automake autoconf gettext \
    zstd bzip2
```

## Configure and build

cd into the `build` subdirectory, run `../configure --disable-multilib`

then (on my system that has 16 threads), `make -j 17`

took about half an hour.

## Install

NOTE: this will forcefully/automatically update the `gcc` symbolic
link; so once done `gcc` will point to the newly installed version!

`sudo make install`

to test `gcc -v`
