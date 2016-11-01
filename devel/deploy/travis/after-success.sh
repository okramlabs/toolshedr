#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

##
# After success script for Toolshedr Server
#
if find "${TRAVIS_BUILD_DIR}/vendor/server" -mindepth 1 -print -quit | grep -q .; then
	log_info "Running post success tasks for Toolshedr Server ..."
	cd $TRAVIS_BUILD_DIR
	bash <(curl -s https://codecov.io/bash)
	wget https://scrutinizer-ci.com/ocular.phar
	php ocular.phar code-coverage:upload --format=php-clover coverage.clover
##
# After success script for Toolshedr UI
#
elif find "${TRAVIS_BUILD_DIR}/vendor/node_modules" -mindepth 1 -print -quit | grep -q .; then
    log_info "Running post success tasks for Toolshedr UI  ..."
##
# This script should only be called on stable build either for Toolshedr Server or UI
#
else
    log_err "Something is wrong - Can't find nor NPM or Composer dependencies!"
    exit 1
fi
exit 0
