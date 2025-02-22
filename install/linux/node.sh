#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source ${HOME}/.zshrc

where nvm

# nvm install --lts
# npm install -g opencommit
# npm i -g gitmoji-cli