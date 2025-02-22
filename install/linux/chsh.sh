#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function load_shell_zsh() {
    chsh -s /usr/bin/zsh
}

function load_shell_bash() {
    chsh -s /usr/bin/bash
}

function main() {
    load_shell_zsh
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi