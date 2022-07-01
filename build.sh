#!/bin/bash

CUR_DIR=$(pwd)
LIBS_DIR=$CUR_DIR/libs
APPS_DIR=$CUR_DIR/apps
LIBS=
APPS=
INSTALL_PATH=$CUR_DIR/build_dir
PROFILE=default
BUILD_DIR=build

export INSTALL_PATH

build() {
	echo "Makeing $1"
	cd ./$1
	if [ -d $BUILD_DIR ]; then
		rm -Rf $BUILD_DIR
	fi
	conan install . --install-folder $BUILD_DIR --profile $PROFILE -b missing
	cd build
	cmake install .. -DCMAKE_INSTALL_PATH=$INSTALL_PATH -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH
	cmake --build . --config Release
	cmake --install . --config Release
	cd ..
}

if [ $1 ]; then 
	if [ -f $1 ]; then
		echo "Found conan profile file"
		PROFILE=`readlink -f $1`
	else
		echo "Not Found profile file"
	fi
fi

echo "Build with profile $PROFILE"

build apps/mos_client_dp
cd $CUR_DIR
