#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

TRAVIS_JOB_NUMBER="39.5"



if [ "${TRAVIS_JOB_NUMBER:${#TRAVIS_JOB_NUMBER}-1:1}" == 5 ]; then
    log_info "Waiting other jobs to finish before we decide either to release or not!!!"    
fi

