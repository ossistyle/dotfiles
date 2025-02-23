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

function install_global_node_modules() {
    npm install -g "${GLOBAL_MODULES[@]}"
}

function uninstall_global_node_modules() {
    npm remove -g "${GLOBAL_MODULES[@]}"
    sudo apt-get install -y build-essential
    sudo apt-get auto-remove -y
}
    
function main() {
    install_dependencies
    install_global_node_modules
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi