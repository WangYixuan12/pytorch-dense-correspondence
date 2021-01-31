#!/bin/bash

set -euxo pipefail

sudo apt-get update
sudo pip install requests
sudo pip install matplotlib
sudo pip install scipy
sudo pip install imageio==2.6.1

sudo pip install scikit-image

sudo pip install tensorboard_logger \
    tensorflow

# seems that we need this version of tensorboard
# maybe because tensorboard_logger is not compatible 
# with newer versions of tensorboard?
sudo pip install tensorboard

sudo pip install sklearn

sudo pip install opencv-contrib-python

sudo apt-get install dialog apt-utils

echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

sudo apt install python-tk \
    ffmpeg
