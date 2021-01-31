#!/bin/bash

set -euxo pipefail

apt-get update
apt install --no-install-recommends \
  terminator \
  tmux \
  vim \
  gedit \
  git \
  openssh-client \
  unzip \
  htop \
  libopenni-dev \
  apt-utils \
  usbutils \
  dialog \
  python-pip \
  python-dev \
  ffmpeg \
  nvidia-settings \
  cmake-curses-gui \
  libyaml-dev

pip install --upgrade pip
pip install -U setuptools

apt-get -y install ipython
pip install \
  ipython[notebook] \
  jupyter \
  opencv-python==4.2.0.32 \
  plyfile \
  pandas \
  tensorflow \
  future \
  typing
