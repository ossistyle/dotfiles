#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly FONT_DIR="${HOME%/}/.local/share/fonts"
readonly NERD_FONTS=(
    "MesloLGS NF Regular.ttf"
    "MesloLGS NF Bold.ttf"
    "MesloLGS NF Italic.ttf"
    "MesloLGS NF Bold Italic.ttf"
)

function install_dependencies() {
    sudo apt-get install -y curl jq
}

function install_nerd_font() {
    local font_url="$1"
    local font_name="$2"
    
    mkdir -p "${FONT_DIR}"
    curl -fSL "${font_url}" -o "${FONT_DIR%/}/${font_name}"
}

function install_font() {    
    for font in "${NERD_FONTS[@]}"; do
        local encoded_font=$(printf %s "${font}"|jq -sRr @uri)
        local font_url="https://github.com/romkatv/powerlevel10k-media/raw/master/${encoded_font}"
        echo "${font}"
        install_nerd_font "${font_url}" ${font}
    done
}

function uninstall_font() {
    for font in "${NERD_FONTS[@]}"; do
        rm -fv "${FONT_DIR}/${font}"
    done
    sudo apt-get remove -y curl jq
}

function main() {
    install_dependencies
    install_font
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi