#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/op.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_op
}

@test "[ubuntu-common] op" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v op)" ]
}