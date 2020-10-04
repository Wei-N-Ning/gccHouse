# Shared Libraries

## On Unix-like system (POSIX), are .so shared by processes

read: <https://stackoverflow.com/questions/4415059/how-is-a-shared-library-file-called-by-two-different-processes-in-linux>

> To emphasize this point, a unixy system can either share or not share
> the dynamic library, but from the application's point of view, there
> is no observable difference between either implementation.

global/static data in the shard libraries are mapped to each process'
own memory space, hence being private to that very process

