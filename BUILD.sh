#!/bin/sh
clear
echo "--------------------------------------------------------------------"
echo "         Building js8lib......."
echo "--------------------------------------------------------------------"

if [ ! -d $HOME/development/JS8Call ]; then
    echo "directory structure does not exist!"
    echo "$HOME/development/JS8Call must be created and the submodules cloned into it"
    echo "exiting......."
    exit;
fi

mkdir ~/development/JS8Call/js8lib

# Build libusb
cd ~/development/JS8Call/submodules/libusb
./bootstrap.sh
./configure --prefix=$HOME/development/JS8Call/js8lib
make && make install
make clean

# Build Hamlib
cd ~/development/JS8Call/submodules/Hamlib
./bootstrap
./configure --prefix=$HOME/development/JS8Call/js8lib
make && make install
make clean

# Build fftw
cd ~/development/JS8Call/submodules/fftw
./configure --prefix=$HOME/development/JS8Call/js8lib --enable-single --enable-threads
make && make install
make clean

# Build boost
cd ~/development/JS8Call/submodules/boost
./bootstrap.sh --prefix=$HOME/development/JS8Call/js8lib
./b2 -a install

#Build Qt6
cd ~/development/JS8Call && mkdir qt6-build && cd qt6-build
~/development/JS8Call/submodules/Qt6/configure -prefix $HOME/development/JS8Call/js8lib -submodules qtbase,qtimageformats,qtmultimedia,qtserialport,qtsvg
cmake --build . --parallel
cmake --install .

cd .. && rm -rf qt6-build

cd ~/development/JS8Call/submodules && git clean -fd
git restore *

cd ..
arch=$(uname -m)
platform=$(uname)

tar -czvf js8lib-2.3_${platform}_${arch}.tar.gz js8lib

clear

echo ""
echo "    DONE!    "
