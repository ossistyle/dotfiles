#!/usr/bin/env bash

set -e pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source ${CHEZMOI_SOURCE_DIR}/../install/ubuntu/utils.sh

header "Installing Packages ..."

install_package "${packages[@]}"

success
