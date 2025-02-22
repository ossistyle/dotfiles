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

readonly SNAPS=(
    btop
)

readonly CLASSIC_SNAPS=(
    code
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
}

function install_apt_snaps() {
    echo "Install snaps"
    for snap in "${SNAPS[@]}"; do   
        echo "Installing $snap ..."       
        ( snap info $snap | grep -q ^installed: | false ) || snap install $snap
        echo "Done $snap"
    done
}

function uninstall_apt_snaps() {
    echo "Uninstall snaps"
    for snap in "${SNAPS[@]}"; do   
        echo "Uninstalling $snap ..."       
        ( snap info $snap | grep -q ^installed: ) || sudo snap remove $snap
    done
}

function install_apt_classic_snaps() {
    echo "Install classic snaps"
    for classic_snap in "${CLASSIC_SNAPS[@]}"; do  
        echo "Installing $classic_snap ..."      
        ( snap info $classic_snap | grep -q ^installed: ) || sudo snap install --classic $classic_snap
    done
}

function uninstall_apt_classic_snaps() {
    echo "Uninstall classic snaps"
    for classic_snap in "${CLASSIC_SNAPS[@]}"; do
        ( snap info $classic_snap | grep -q ^installed: ) || sudo snap remove $classic_snap
    done
}

function uninstall_apt_all_snaps() {
    uninstall_apt_snaps
    uninstall_apt_classic_snaps
}


function main() {
    update_apt_package
    install_apt_packages
    install_apt_snaps
    install_apt_classic_snaps
    set_local
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi