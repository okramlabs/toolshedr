#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

##
# Before script for Toolshedr Deploy task
#
if [ "${TRAVIS_JOB_NUMBER:${#TRAVIS_JOB_NUMBER}-1:1}" -eq 5 ]; then
    log_info "We have to Wait other jobs to finish before we decide either to release or not!!!"  
##
# Before script for Toolshedr Jobs
#
elif [ "${TRAVIS_JOB_NUMBER:${#TRAVIS_JOB_NUMBER}-1:1}" -lt 5 ]; then
    log_info "Shared before_script..."
##
# Unexpected Job number
#
else
    log_warn "Got unexpected job number!!!"
fi
