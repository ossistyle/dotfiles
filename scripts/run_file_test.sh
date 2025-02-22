#!/usr/bin/env bash

set -Eeuo pipefail

function run_os_specific_test() {    
    kcov --clean \
        --debug-force-bash-stderr \
        --include-path=install/linux \
        "./coverage_linux" \
        bats -r "tests/files/linux/"   
}

function merge_coverage_results() {    
    kcov --merge ./coverage \
        "./coverage_linux" \
    
}

function main() {
    run_os_specific_test
    merge_coverage_results
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main
fi