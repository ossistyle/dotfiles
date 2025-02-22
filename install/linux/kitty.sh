#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_kitty() {
# https://sw.kovidgoyal.net/kitty/quickstart/

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
    launch=n
}

function uninstall_kitty() {
    rm -rf "${HOME}/.local/kitty.app"
}

function main() {
    install_kitty
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi