#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/font.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_font
}

@test "[ubuntu-common] font" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"
    for font in "${NERD_FONTS[@]}"; do
        [ -f "${FONT_DIR}/${font}" ]
    done
}