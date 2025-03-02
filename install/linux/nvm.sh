#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly _NVM_DIR="$HOME/.nvm"

function install_dependencies() {
    sudo apt-get update 
    sudo apt-get install -y curl unzip tar xz-utils build-essential libssl-dev curl git-core
}

function install_nvm() {
    rm -rf "$_NVM_DIR"
    if [ ! -d "$_NVM_DIR" ]; then
        mkdir "$_NVM_DIR"
        export NVM_DIR=$_NVM_DIR
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash        
    fi
    . "$NVM_DIR/nvm.sh"    
}   

function uninstall_nvm() {
    rm -rf $NVM_DIR
    sudo apt-get remove -y curl unzip xz-utils build-essential libssl-dev curl git-core
    sudo apt-get autoremove -y
  
}

function main() {
    install_dependencies
    install_nvm
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi