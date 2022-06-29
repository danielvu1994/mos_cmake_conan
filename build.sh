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
	conan build . --build-folder $BUILD_DIR
	cd ..
}

build_lib() {
	#echo "List of libs: $LIBS"
	cd $LIBS_DIR
	#for LIB in $LIBS
	#do
	#	build $LIB
	#done

	#Temporary not have autodetect dependencies so use this insted
	build my_print
	build mos_utils
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
fi

#Get apps list
if [ -d $APPS_DIR ]; then
	APPS=`ls $APPS_DIR`
fi

if [ $1 ]; then 
	if [ -f $1 ]; then
		echo "Found conan profile file"
		PROFILE=`readlink -f $1`
	else
		echo "Not Found profile file"
	fi
fi

echo "Build with profile $PROFILE"

build_lib
build_app
cd $CUR_DIR
