#!/usr/bin/env bash

set -e pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source ${CHEZMOI_SOURCE_DIR}/../install/ubuntu/utils.sh

header "Installing Node Version Manager (nvm) ..."

# https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

success
