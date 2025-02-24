#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/kitty.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_kitty

    # reset PATH
    PATH=$(getconf PATH)
    export PATH
}

@test "[ubuntu-common] kitty" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    export PATH="${PATH}:${HOME%/}/.local/bin"
    [ -x "$(command -v kitty)" ]
}