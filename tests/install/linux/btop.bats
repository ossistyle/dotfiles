#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/btop.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_btop
}

@test "[ubuntu-common] btop" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v btop)" ]
}