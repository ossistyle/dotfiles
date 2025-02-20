#!/usr/bin/env bash

set -e pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source ${CHEZMOI_SOURCE_DIR}/../install/ubuntu/utils.sh

header "Changing Login Shell to ZSH ..."

chsh -s /usr/bin/zsh

success
