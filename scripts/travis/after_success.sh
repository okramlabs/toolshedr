#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

if find "${TRAVIS_BUILD_DIR}/vendor/server" -mindepth 1 -print -quit | grep -q .; then
	log_info "Running post success tasks for Toolshedr Server ..."

elif find "${TRAVIS_BUILD_DIR}/vendor/node_modules" -mindepth 1 -print -quit | grep -q .; then
    log_info "Running post success tasks for Toolshedr UI  ..."
else
    log_err "Something is wrong nor TRAVIS_PHP_VERSION or TRAVIS_NODE_VERSION are set!"
    exit 1
fi
exit 0
