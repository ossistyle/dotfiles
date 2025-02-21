#!/bin/bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

source install/linux/client/docker.sh
main

# Mounts dotfiles into a Docker container, installs them, and drops you into a prompt.

# POSIX way to get script's dir: https://stackoverflow.com/a/29834779/12156188
script_dir="$(cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P)"

exec docker run --rm -it --env DEBUG_DOTFILES=1 -v "$script_dir":/home/vscode/dotfiles --user vscode --workdir /home/vscode mcr.microsoft.com/devcontainers/base:ubuntu bash -c 'sh /home/vscode/dotfiles/install.sh && bash'
