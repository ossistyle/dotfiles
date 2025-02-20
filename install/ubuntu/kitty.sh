#!/usr/bin/env bash

set -e pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source ${CHEZMOI_SOURCE_DIR}/../install/ubuntu/utils.sh

header "Installing Kitty ..."

# https://sw.kovidgoyal.net/kitty/quickstart/

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

success
