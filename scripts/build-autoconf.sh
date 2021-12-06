#!/usr/bin/env bash

set -e

sudo apt-get update -y
sudo apt-get install -y build-essential m4
curl -O http://ftp.gnu.org/gnu/autoconf/autoconf-2.71.tar.gz
tar xvf autoconf-2.71.tar.gz
cd autoconf-2.71
./configure
make
sudo make install
autoconf --version
