#!/usr/bin/env bash

set -Eeuo pipefail

function run_os_specific_test() {
    if [ "${OS}" == "ubuntu-latest" ]; then
        kcov --clean \
            --debug-force-bash-stderr \
            --include-path=install/linux/common/ \
            "./coverage_ubuntu_common" \
            bats -r "tests/install/linux/common/"
    else
        echo "${OS} and ${SYSTEM} are not supported" >&2
        exit 1
    fi
}

function merge_coverage_results() {
    if [ "${OS}" == "ubuntu-latest" ]; then
        kcov --merge ./coverage \
            "./coverage_common" \
            "./coverage_ubuntu_common" \
            "./coverage_ubuntu_${SYSTEM}"
    else
        echo "${OS} and ${SYSTEM} are not supported" >&2
        exit 1
    fi
}

function main() {
    run_os_specific_test
    merge_coverage_results
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi