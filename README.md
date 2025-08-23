# JS8Call Developer's Submodule Repository

- This repository is only for JS8Call developers to build and package pre-built libraries for JS8Call. It is not intended for end users
to build the code.
- The base repository contains the source code for FFTW-3.3.10
- Qt6 v6.6.3, Hamlib v4.6.4, libusb-1.0.29 and Boost 1.88.0 are obtained as submodules with `git submodule update --init --recursive` after
cloning this repository.

# Building and Creating a JS8Call Library Package
- To build a library package you must create the proper directory structure on your development machine. The following command will
accomplish this:
```
mkdir ~/development && mkdir ~/development/JS8Call
```
- cd into ~/development/JS8Call and clone this repository with:
```
git clone https://github.com/Chris-AC9KH/js8lib.git submodules
```
- You will want to validate your library build by using it to build JS8Call. So if you don't already have it, clone the JS8Call source
code to ~/development/JS8Cal/src with:
```
cd ~/development/JS8Call && git clone https://github.com/js8call/js8call.git src
```
- cd into submodules and run the BUILD.sh script with `./BUILD.sh`. This will create a js8lib folder in the project root which will
contain the uncompressed library build. If the build is successful it will also create a gzipped tar archive of the library build
in the project root. Depending on the capabilities of your build machine this can take a long time. The build script
will automatically run `git submodule update --init --recursive` to initialize the submodules.

- After the build completes you can validate the library build by using it to build JS8Call with a CMake prefix path of
~/development/JS8Call/js8lib

- The BUILD.sh script will remove the qt6-build artifact from the project root if the Qt6 build is successful.
