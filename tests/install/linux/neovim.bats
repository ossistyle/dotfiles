#!/usr/bin/env bats

readonly SCRIPT_PATH="install/linux/neovim.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_neovim
}

@test "[common] neovim" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    [ -x "$(command -v nvim)" ]
}