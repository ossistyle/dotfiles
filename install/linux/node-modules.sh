#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly GLOBAL_MODULES=(
    opencommit
    gitmoji-cli    
)

function install_dependencies() {
    sudo apt-get update 
    sudo apt-get install -y build-essential
}

function check_nvm_installation() {
    if [ ! -s "$NVM_DIR/nvm.sh" ]; then
        echo "To install node modules, you must run 'bash install/linux/nvm.sh' before." >&2
        exit 1
    fi
    . "$NVM_DIR/nvm.sh"
}

function _install_node() {
    nvm install --lts
}

function check_node_installation() {
    if ! command -v node &> /dev/null; then
        _install_node
    fi
}

function install_global_node_modules() {
    npm install -g "${GLOBAL_MODULES[@]}"
}

function uninstall_global_node_modules() {
    npm remove -g "${GLOBAL_MODULES[@]}"
}
    
function main() {
    install_dependencies
    check_nvm_installation
    check_node_installation
    uninstall_global_node_modules
    install_global_node_modules
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi