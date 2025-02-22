#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
}

function setup_nvm() {
    echo "Setup NVM ..."
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && echo "loading" && \. "$NVM_DIR/nvm.sh" # This loads nvm # --no-use # This loads nvm, without auto-using the default version

}

function main() {
    install_nvm
    setup_nvm
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi