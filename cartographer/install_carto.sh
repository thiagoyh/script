#!/bin/bash

cd ~
mkdir cartographer_install
cd ~/cartographer_install/cartographer_install

git clone https://github.com/Thiagoyh/protobuf_install.git
git clone https://github.com/Thiagoyh/ceres-solver_install.git

git clone https://github.com/abseil/abseil-cpp.git


sudo apt-get install \
    clang \
    cmake \
    g++ \
    git \
    google-mock \
    libboost-all-dev \
    libcairo2-dev \
    libcurl4-openssl-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblua5.2-dev \
    libsuitesparse-dev \
    lsb-release \
    ninja-build \
    stow \
    python-wstool \
    python-rosdep \
	python-sphinx \
	libatlas-base-dev



# Build and install abseil-cpp
set -o errexit
set -o verbose

cd abseil-cpp
git checkout d902eb869bcfacc1bad14933ed9af4bed006d481
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_INSTALL_PREFIX=/usr/local/stow/absl \
  ..
ninja
sudo ninja install
cd /usr/local/stow
sudo stow absl


# Build and install Ceres.
cd -
cd ../../ceres-solver_install
mkdir build
cd build
cmake .. -G Ninja -DCXX11=ON
ninja
#CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install


# Build and install proto3.
cd ../../protobuf_install
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  ../cmake
ninja
sudo ninja install



#ros install cartographer

cd ~

mkdir -p ~/catkin_carto/src
cd ~/catkin_carto/src
catkin_init_workspace

git clone https://github.com/cartographer-project/cartographer.git
git clone https://github.com/cartographer-project/cartographer_ros.git

cd ~/catkin_carto

catkin_make_isolated --install --use-ninja
#catkin_make_isolated --install --use-ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=Yes

source install_isolated/setup.bash
