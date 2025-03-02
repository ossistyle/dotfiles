#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

# readonly FZF_DIR="${HOME%/}/.fzf"
# readonly FZF_URL="https://github.com/junegunn/fzf.git"

# function clone_fzf() {
#     if [ ! -d "${FZF_DIR}" ]; then
#         git clone "${FZF_URL}" "${FZF_DIR}"
#     fi
# }

function install_fzf() {
    sudo apt-get install -y fzf
}

function uninstall_fzf() {
    sudo apt-get remove -y fzf
}

function main() {
    install_fzf
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi