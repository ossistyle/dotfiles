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
    if ! [ -x "$(command -v nvm)" ]; then
        #(exec ./install/linux/nvm.sh)
        echo "To install node modules, you must run './install/linux/nvm.sh' first." >&2
        exit 1
    fi
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function _install_node() {
    nvm install node
    nvm install --lts
}

function check_node_installation() {
    if ! [ -x "$(command -v node)" ]; then
        nvm install node
    fi
}

function install_global_node_modules() {
    npm install -g "${GLOBAL_MODULES[@]}"
}

function uninstall_global_node_modules() {
    npm remove -g "${GLOBAL_MODULES[@]}"
}
    
function main() {
    # install_dependencies
    check_nvm_installation
    check_node_installation
    uninstall_global_node_modules
    install_global_node_modules
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi