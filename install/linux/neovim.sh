#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_neovim() {
    sudo apt-get update
    sudo apt-get install -y neovim python3-neovim
}

function uninstall_neovim() {
    sudo apt-get remove -y neovim python3-neovim
    sudo apt-get autoremove -y
}

function main() {
    install_neovim
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi