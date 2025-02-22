#!/usr/bin/env bash

set -Eeuo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

readonly EXTENSIONS=(
    asvetliakov.vscode-neovim
    eamodio.gitlens
    EditorConfig.EditorConfig
    golang.go
    esbenp.prettier-vscode
    jinliming2.vscode-go-template
    ms-python.python
    ms-python.pylint
    redhat.vscode-yaml
    streetsidesoftware.code-spell-checker
)

install_vscode_extensions() {
    code --force --install-extension "${EXTENSIONS[@]}"
}

function main() {
    install_vscode_extensions
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi