#!/bin/sh
clear
echo "--------------------------------------------------------------------"
echo "         Initalizing submodules........."
echo "--------------------------------------------------------------------"
clear
echo "--------------------------------------------------------------------"
echo "         Building js8lib........."
echo "--------------------------------------------------------------------"
sleep 2

if [ ! -d $HOME/development/JS8Call ]; then
    echo "directory structure does not exist!"
    echo "$HOME/development/JS8Call must be created and the submodules cloned into it"
    echo "exiting......."
    exit;
fi

if [ -d $HOME/development/JS8Call/src ]; then
    echo "$HOME/development/JS8Call/src directory already exists"
    echo "delete it or archive it, then run this script again"
    echo "exiting......."
    exit;
fi

if [ -d $HOME/development/JS8Call/js8lib ]; then
    echo "$HOME/development/JS8Call/js8lib directory already exists"
    echo "delete it or archive it, then run this script again"                        
    echo "exiting......."
    exit;
fi

mkdir ~/development/JS8Call/js8lib

# Build libusb
cd ~/development/JS8Call/submodules/libusb
if  ./bootstrap.sh
    ./configure --prefix=$HOME/development/JS8Call/js8lib
    make && make install
    make clean; then
    echo "--------------------------------------------------------------------"
    echo "         libusb-v1.0.29 build successful........."
    echo "--------------------------------------------------------------------"
    sleep 5
    clear
else
    echo "--------------------------------------------------------------------"
    echo "         libusb build failed........."
    echo "--------------------------------------------------------------------"
    exit;
fi

# Build Hamlib
cd ~/development/JS8Call/submodules/Hamlib
if  ./bootstrap
    ./configure --prefix=$HOME/development/JS8Call/js8lib
    make && make install
    make clean; then
        echo "--------------------------------------------------------------------"
        echo "         Hamlib-v4.6.4 build successful........."
        echo "--------------------------------------------------------------------"
        sleep 5
        clear
else
    echo "--------------------------------------------------------------------"
    echo "         Hamlib build failed........."
    echo "--------------------------------------------------------------------"
    exit;
fi

# Build fftw
if cd ~/development/JS8Call/submodules/fftw
    ./configure --prefix=$HOME/development/JS8Call/js8lib --enable-single --enable-threads
    make && make install
    make clean; then
        echo "--------------------------------------------------------------------"
        echo "         fftw-v3.3.10 build successful........."
        echo "--------------------------------------------------------------------"
        sleep 5
        clear
else
    echo "--------------------------------------------------------------------"
    echo "         fftw build failed........."
    echo "--------------------------------------------------------------------"
    exit;
fi

# Build boost
    cd ~/development/JS8Call/submodules/boost
    ./bootstrap.sh --prefix=$HOME/development/JS8Call/js8lib
    ./b2 -a install
    echo "--------------------------------------------------------------------"
    echo "         boost-v1.88.0 build successful........."
    echo "--------------------------------------------------------------------"
    sleep 5

#Build Qt6
cd ~/development/JS8Call && mkdir qt6-build && cd qt6-build
if  ~/development/JS8Call/submodules/Qt6/configure -prefix $HOME/development/JS8Call/js8lib -submodules qtbase,qtimageformats,qtmultimedia,qtserialport,qtsvg
    cmake --build . --parallel
    cmake --install . ; then
    echo "--------------------------------------------------------------------"
    echo "         Qt6-v6.6.3 build successful........."
    echo "--------------------------------------------------------------------"
    sleep 5
    clear
else
    echo "--------------------------------------------------------------------"
    echo "         Qt6 build failed........."
    echo "--------------------------------------------------------------------"
    exit;
fi

clear

echo "--------------------------------------------------------------------"
echo "         validating library build........."
echo "--------------------------------------------------------------------"

if cd $HOME/development/JS8Call
    git clone https://github.com/js8call/js8call.git src
    cd src && mkdir build && cd build
    cmake -DCMAKE_PREFIX_PATH=~/development/JS8Call/js8lib \
      -DCMAKE_BUILD_TYPE=Release ..; then
    echo "--------------------------------------------------------------------"
    echo "         library validated: build successful........."
    echo "--------------------------------------------------------------------"
    sleep 2
    echo "--------------------------------------------------------------------"
    echo "         cleaning source tree........."
    echo "--------------------------------------------------------------------"
    sleep 2
    rm -rf $Home/development/JS8Call/qt6-build src
    cd ~/development/JS8Call/submodules && git clean -fd
    git restore *
    clear
else
    echo "--------------------------------------------------------------------"
    echo "  build failed: library is corrupted or missing components..."
    echo "--------------------------------------------------------------------"
    exit;
fi

cd $HOME/development/JS8Call
arch=$(uname -m)
platform=$(uname)

# create downloadable pre-built library archive
tar -czvf js8lib-2.3_${platform}_${arch}.tar.gz js8lib

clear

echo "library archive created in $Home/development/JS8Call...."
echo "    DONE!    "
