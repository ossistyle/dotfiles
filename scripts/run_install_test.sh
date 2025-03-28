#!/usr/bin/env bash

set -eufo pipefail

if [ "${DOTFILES_DEBUG:-}" ]; then
    set -x
fi

function install_dependencies() {
    command -v kcov || bash ./install/linux/kcov.sh
    command -v bats || sudo apt-get install -y bats parallel
}

function run_os_specific_test() {    
    kcov --clean \
        --include-path=./install/linux/ \
        "./coverage_linux" \
        bats -r "./tests/install/linux/"
}

function merge_coverage_results() {    
    kcov --merge ./coverage \
        "./coverage_linux" \    
}

function main() {
    install_dependencies
    run_os_specific_test
    merge_coverage_results
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi