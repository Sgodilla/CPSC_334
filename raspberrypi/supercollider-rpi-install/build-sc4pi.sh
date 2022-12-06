#!/bin/sh

# Modified version of this script: https://github.com/lvm/build-supercollider
# Inspired by this: https://github.com/supercollider/supercollider/blob/develop/README_RASPBERRY_PI.md

###
#
# Variables
#
INSTALL_DIR=/tmp
SUPERCOLLIDER_VER=3.12
SUPERCOLLIDER_DIR=$INSTALL_DIR/supercollider
SUPERCOLLIDER_BUILD_DIR=$SUPERCOLLIDER_DIR/build

###
#
# Update
#
sudo apt update

###
#
# Install building dependencies
#
sudo apt-get install libsamplerate0-dev libsndfile1-dev libasound2-dev libavahi-client-dev \
    libreadline-dev libfftw3-dev libudev-dev cmake git libjack-jackd2-dev
###
#
# Download and build SC
#
mkdir -p $SUPERCOLLIDER_DIR

# Download SC Source
git clone --recursive --branch $SUPERCOLLIDER_VER \
    https://github.com/supercollider/supercollider.git $SUPERCOLLIDER_DIR

# Create the the directory where SC will be built
mkdir -p $SUPERCOLLIDER_BUILD_DIR

# And build it.
cd $SUPERCOLLIDER_BUILD_DIR && \
        # For a GUI-less build:
        cmake -DCMAKE_BUILD_TYPE=Release -DSUPERNOVA=OFF -DSC_ED=OFF -DSC_EL=OFF -DSC_VIM=ON -DNATIVE=ON \
        -DSC_IDE=OFF -DNO_X11=ON -DSC_QT=OFF ..
    make -j4 && \
    sudo make install && \
    sudo ldconfig
