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
    dbaeumer.vscode-eslint
    esbenp.prettier-vscode
    jinliming2.vscode-go-template
    ms-python.python
    ms-python.pylint
    ms-vscode-remote.remote-containers
    ms-vscode-remote.remote-ssh
    ms-vscode-remote.remote-ssh-edit
    ms-vscode-remote.vscode-remote-extensionpack
    ms-vscode.cpptools
    redhat.vscode-yaml
    stkb.rewrap
    streetsidesoftware.code-spell-checker
    tamasfe.even-better-toml
    twpayne.vscode-igc
    twpayne.vscode-testscript
    Tyriar.sort-lines
    yzhang.markdown-all-in-one
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