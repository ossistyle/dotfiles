#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_vscode() {
    sudo apt-get install -y wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg

    sudo apt install -y apt-transport-https
    sudo apt update
    sudo apt install -y code # or code-insiders
    
}

function uninstall_vscode() {
    sudo apt-get remove -y code
    sudo apt-get autoremove -y
}

function main() {
    install_vscode
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi