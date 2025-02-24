#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/vscode.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_vscode
}

@test "[ubuntu-common] vscode" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v code)" ]
}