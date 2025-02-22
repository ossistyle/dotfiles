#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/kitty.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_kitty
}

@test "[ubuntu-common] golang" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    [ -x "$(command -v kitty)" ]
}