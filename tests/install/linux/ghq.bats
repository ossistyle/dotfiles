#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/ghq.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_ghq

    # reset PATH
    PATH=$(getconf PATH)
    export PATH
}

@test "[linux] ghq" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    export PATH="${PATH}:${HOME%/}/.local/bin"
    [ -x "$(command -v ghq)" ]
}