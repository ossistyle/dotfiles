#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/kcov.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

@test "[ubuntu-common] kcov" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    [ -x "$(command -v kcov)" ]
}