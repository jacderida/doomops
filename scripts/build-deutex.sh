#!/usr/bin/env bash

sudo apt-get install -y automake pkg-config
git clone https://github.com/Doom-Utils/deutex
cd deutex
./bootstrap
./configure
make
sudo make install
deutex --version
