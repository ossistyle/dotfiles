#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly DEST_DIR="$HOME/.btop"

function install_dependencies() {
    sudo apt-get install -y coreutils sed git build-essential gcc-11 g++-11 lowdown
}

function install_btop() {
    rm -rf "$DEST_DIR"
    git clone https://github.com/aristocratos/btop.git "$DEST_DIR"
    cd "$DEST_DIR"
    make
    sudo make install
}

function uninstall_btop() {
    cd "$DEST_DIR"
    sudo make uninstall
    rm -rf "$DEST_DIR"
}

function main() {
    install_dependencies
    install_btop
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi