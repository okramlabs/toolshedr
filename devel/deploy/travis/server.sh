#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

# Start the job
log_ok "Loaded Toolshedr Server build script!"

##
# All tasks to build and tests Toolshedr Server should be called from here
#
if [ -n "${TRAVIS_PHP_VERSION+1}" ]; then
	log_info "Starting build of Toolshedr Server with PHP ${TRAVIS_PHP_VERSION}."
	log_info "PWD: $(pwd)"

	# Load Server build tasks
	source "$TCI_RUNNER_PWD/tasks/server-tasks.sh"

	log_ok "Toolshedr Server Job DONE !!!"
else
    log_warn "This Job should not call Toolshedr Server build script."
fi
exit 0
