#!/usr/bin/env bash

set -e

function install_dependencies() {
    sudo apt-get install -y build-essential cmake
}

function build_odasrv() {
    [[ ! -d "odamex" ]] && git clone https://github.com/odamex/odamex.git --recurse-submodules
    [[ ! -d "odamex/build" ]] && mkdir odamex/build
    (
        cd odamex/build
        cmake ..
        make odasrv
        sudo cp server/odasrv /usr/local/bin
    )
}

function build_odamex_wad() {
    (
        cd odamex/wad
        deutex -rgb 0 255 255 -doom2 bootstrap -build wadinfo.txt ../odamex.wad
    )
}

sudo apt-get update -y
install_dependencies
build_odasrv
build_odamex_wad
