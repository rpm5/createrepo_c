#!/bin/sh

rm -rf build

mkdir build
cd build && cmake \
	-DCMAKE_BUILD_TYPE:STRING=DEBUG \
        -DCMAKE_C_FLAGS:STRING="-I/opt/local/include/rpm" \
        -DCMAKE_C_FLAGS_RELEASE:STRING="-DNDEBUG" \
        -DCMAKE_CXX_FLAGS_RELEASE:STRING="-DNDEBUG" \
        -DCMAKE_Fortran_FLAGS_RELEASE:STRING="-DNDEBUG" \
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
        -DCMAKE_INSTALL_PREFIX:PATH=/opt/local \
        -DCMAKE_INSTALL_RPATH:PATH=/opt/local/lib \
        -DINCLUDE_INSTALL_DIR:PATH=/opt/local/include \
        -DLIB_INSTALL_DIR:PATH=/opt/local/lib \
        -DSYSCONF_INSTALL_DIR:PATH=/opt/local/etc \
        -DSHARE_INSTALL_PREFIX:PATH=/opt/local/share \
        -DBUILD_SHARED_LIBS:BOOL=ON \
        -DENABLE_DRPM:BOOL=OFF \
    -DPYTHON_DESIRED="2" \
    -DRPM5="1" \
    -DMACOSX="0" \
	../

cd build
make && make tests && make ARGS="-VV --debug" test # && sudo make install
