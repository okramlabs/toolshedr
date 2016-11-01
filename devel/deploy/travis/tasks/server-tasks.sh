#!/bin/bash
#########
# CHECKS
#########

# Are NPM dependencies installed?
if find "${TRAVIS_BUILD_DIR}/vendor/node_modules" -mindepth 1 -print -quit | grep -q .; then
    log_ok "NPM dependencies are installed or cached!"
else
    log_info "NPM dependencies are not installed or cached!"
fi

#########
# TASKS
#########
log_info "Install composer dependencies"
composer install

log_info "Run phpunit tests"
cd $TRAVIS_BUILD_DIR/tests/server
phpunit --coverage-clover="../../coverage.clover"
