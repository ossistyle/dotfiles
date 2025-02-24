#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly LOCALE="en_US.UTF-8"

readonly PACKAGES=( 
    curl
    gpg
    fd-find
    jq
    shellcheck
    locales
    unzip
    vim
    wget
    zsh
)

function update_apt_package() {
    sudo apt-get update
}

function install_apt_packages() {    
    sudo apt-get install -y "${PACKAGES[@]}"    
}

function set_local() {
    sudo locale-gen $LOCALE
}

function uninstall_apt_packages() {
    sudo apt-get remove -y "${PACKAGES[@]}"
    sudo apt-get auto-remove -y
}

function main() {
    update_apt_package
    install_apt_packages
    set_local
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi