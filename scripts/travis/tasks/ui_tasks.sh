#!/bin/bash

#########
# CHECKS
#########

# Are composer dependencies installed?
if find "${TRAVIS_BUILD_DIR}/vendor/server" -mindepth 1 -print -quit | grep -q .; then
    log_ok "Composer dependencies are installed or cached!"
else
    log_info "Composer dependencies are not installed or cached!"
fi

#########
# TASKS
#########
log_info "Install npm dependencies"
