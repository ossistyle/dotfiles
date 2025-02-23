#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_op() {
    curl -sS https://downloads.1password.com/linux/keys/1password.asc |
        sudo gpg --yes --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
        sudo tee /etc/apt/sources.list.d/1password.list

    sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
    curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol |
        sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
    sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
    curl -sS https://downloads.1password.com/linux/keys/1password.asc |
        sudo gpg --yes --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

    sudo apt update
    sudo apt install -y 1password-cli
}

function uninstall_op() {
    op account forget --all
    rm /usr/local/bin/op
}

function main() {
    install_op
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi