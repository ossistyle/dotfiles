#!/usr/bin/env bats

readonly SCRIPT_PATH="./install/linux/misc.sh"

readonly expected_packages=(
    curl
    gpg
    fd-find
    jq
    shellcheck
    locales
    unzip
    vim
    wget
    zsh
)

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
    [ $num_packages -eq 10 ]

    
    for ((i = 0; i < ${#expected_packages[*]}; ++i)); do
        [ "${PACKAGES[$i]}" == "${expected_packages[$i]}" ]
    done
}

@test "[ubuntu-common] misc" {
    DOTFILES_DEBUG=1 bash "${SCRIPT_PATH}"

    for ((i = 0; i < ${#expected_packages[*]}; ++i)); do        
        package="${expected_packages[$i]}"
        if [ "${expected_packages[$i]}" == "locales" ]; then 
            package="locale-gen"
        fi
        if [ "${expected_packages[$i]}" == "fd-find" ]; then 
            package="fdfind"
        fi
        echo "Check package "${package}" ..."
        [ -x "$(command -v "${package}")" ]
    done
}