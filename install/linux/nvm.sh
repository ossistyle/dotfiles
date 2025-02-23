#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_dependencies() {
    sudo apt-get update
    sudo apt-get install -y curl unzip tar xz-utils
}

function install_nvm() {
    export NVM_DIR="$HOME/.nvm"

    if [ ! -d "$NVM_DIR" ]; then
        git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	    cd "$NVM_DIR"
	    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)` 
    fi
    . "$NVM_DIR/nvm.sh"
    nvm install --lts
}   

function install_node_lts() {
    eval $(/bin/bash --login -c "nvm install node")
}

function uninstall_nvm() {
    rm -rf $NVM_DIR
    sudo apt-get autoremove -y
}

function main() {
    install_dependencies
    install_nvm
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi