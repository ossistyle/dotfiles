#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/misc.sh"

function setup() {
    source "${SCRIPT_PATH}"
}

function teardown() {
    run uninstall_apt_packages

    # PATH=$(getconf PATH)
    # export PATH
}

@test "[ubuntu-common] PACKAGES for misc" {
    num_packages="${#PACKAGES[@]}"
    [ $num_packages -eq 11 ]

    expected_packages=(
        curl
        gpg
        fd-find
        jq
        shellcheck
        locales
        unzip
        vim
        wget
        libfuse2
        zsh
    )
    for ((i = 0; i < ${#expected_packages[*]}; ++i)); do
        [ "${PACKAGES[$i]}" == "${expected_packages[$i]}" ]
    done
}

@test "[ubuntu-common] misc" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    
    [ -x "$(command -v curl)" ]
    [ -x "$(command -v gpg)" ]
    [ -x "$(command -v jq)" ]
    [ -x "$(command -v fdfind)" ]
    [ -x "$(command -v btop)" ]
    [ -x "$(command -v shellcheck)" ]
    [ -x "$(command -v vim)" ]
    [ -x "$(command -v unzip)" ]
    [ -x "$(command -v locale-gen)" ]
    [ -x "$(command -v wget)" ]
    [ -x "$(command -v zsh)" ]
}