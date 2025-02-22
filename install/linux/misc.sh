#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly LOCALE=en_US.UTF-8

readonly PACKAGES=(
    busybox
    curl
    gpg
    fd-find
    jq
    shellcheck
    libfuse2
    unzip
    vim
    wget
    zsh
)

readonly SNAPS=(
    btop
)

readonly CLASSIC_SNAPS=(
    code
)

function install_apt_packages() {
    sudo apt-get install -y "${PACKAGES[@]}"    
}

function set_local() {
    locale-gen $LOCALE
}

function uninstall_apt_packages() {
    sudo apt-get remove -y "${PACKAGES[@]}"
}

function install_apt_snaps() {
    for snap in "${SNAPS[@]}"; do
        if dpkg -s "${snap}" >/dev/null 2>&1; then
            ( snap info "${snap}" | grep -q ^installed: ) || snap install "${snap}"
        fi
    done
}

function uninstall_apt_snaps() {
    for snap in "${SNAPS[@]}"; do
        if dpkg -s "${snap}" >/dev/null 2>&1; then
            ( snap info "${snap}" | grep -q ^installed: ) || snap remove "${snap}"
        fi
    done
}

function install_apt_classic_snaps() {
    for snap in "${CLASSIC_SNAPS[@]}"; do
        if dpkg -s "${snap}" >/dev/null 2>&1; then
            ( snap info "${snap}" | grep -q ^installed: ) || snap install --classic "${snap}"
        fi
    done
}

function uninstall_apt_classic_snaps() {
    for snap in "${SNAPS[@]}"; do
        if dpkg -s "${snap}" >/dev/null 2>&1; then
            ( snap info "${snap}" | grep -q ^installed: ) || snap remove "${snap}"
        fi
    done
}


function main() {
    install_apt_packages
    install_apt_snaps
    install_apt_classic_snaps
    set_local
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi