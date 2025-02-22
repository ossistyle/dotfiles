#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/chezmoi.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_chezmoi
}

@test "[ubuntu-common] chezmoi" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v chezmoi)" ]
}