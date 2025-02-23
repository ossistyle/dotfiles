#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_dependencies() {
    sudo apt-get install -y curl
}

function install_kitty() {
    # https://sw.kovidgoyal.net/kitty/quickstart/

    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | bash /dev/stdin \
        launch=n
}

function symlink_kitty_binary() {
  ln -snf "$HOME"/.local/kitty.app/bin/kitty "$HOME"/.local/bin/
  ln -snf "$HOME"/.local/kitty.app/bin/kitten "$HOME"/.local/bin/

}

function uninstall_kitty() {
    rm -rf "${HOME}/.local/kitty.app"
    rm -rf "${HOME}/.local/bin/kitty"
    rm -rf "${HOME}/.local/bin/kitten"
    sudo apt-get remove -y curl
    sudo apt-get auto-remove -y
}

function main() {
    install_dependencies
    install_kitty
    symlink_kitty_binary
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi