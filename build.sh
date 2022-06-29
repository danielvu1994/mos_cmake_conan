#!/bin/bash

CUR_DIR=$(pwd)
LIBS_DIR=$CUR_DIR/libs
APPS_DIR=$CUR_DIR/apps
LIBS=
APPS=
INSTALL_PATH=$CUR_DIR/build_dir

export INSTALL_PATH

build() {
	echo "Makeing $1"
	cd ./$1
	if [ ! -d build ]; then
		mkdir build
	fi
	cd build
       	conan install ..
       	cmake .. && make &&  make install ..
	cd ../..
}

build_lib() {
	echo "List of libs: $LIBS"
	cd $LIBS_DIR
	for LIB in $LIBS
	do
		build $LIB
	done
}

build_app() {
	echo "List of apps: $APPS"
	cd $APPS_DIR
	for APP in $APPS
	do
		build $APP
	done
}
#Get libs list
if [ -d $LIBS_DIR ]; then
	LIBS=`ls $LIBS_DIR`
	echo "Hehe"
fi

#Get apps list
if [ -d $APPS_DIR ]; then
	APPS=`ls $APPS_DIR`
fi

echo $LIST_LIBS

build_lib
build_app
