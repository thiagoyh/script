 
#!/bin/bash

mkdir ~/lib/
cd ~/lib
git clone https://github.com/ethz-asl/libnabo.git

cd libnabo
SRC_DIR=`pwd`
BUILD_DIR=${SRC_DIR}/build
mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ${SRC_DIR}
make
sudo make install
