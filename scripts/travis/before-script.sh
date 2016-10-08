#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

if [ "${TRAVIS_JOB_NUMBER:${#TRAVIS_JOB_NUMBER}-1:1}" -eq 5 ]; then
    log_info "Waiting other jobs to finish before we decide either to release or not!!!"  
elif [ "${TRAVIS_JOB_NUMBER:${#TRAVIS_JOB_NUMBER}-1:1}" -lt 5 ]; then
    log_info "Shared before_script..."
fi
