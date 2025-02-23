#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/nvm.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_nvm
}

@test "[ubuntu-common] nvm" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v nvm)" ]
}