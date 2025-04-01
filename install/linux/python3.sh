#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_python() {
    sudo apt-get update
    sudo apt-get install -y python3 python3-pip 
}

function uninstall_python() {
    sudo apt-get remove -y python3 python3-pip 
    sudo apt-get autoremove -y
}

function main() {
    install_python
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi