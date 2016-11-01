#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

# Start the job
log_ok "Loaded Toolshedr UI build script!"

##
# All tasks to build and tests Toolshedr UI should be called from here
#
if [ "${TRAVIS_NODE_VERSION+1}" ]; then
	log_info "Starting build of Toolshedr UI with node ${TRAVIS_NODE_VERSION}" 
    log_info "PWD: $(pwd)"

    # Set node_modules path to vendor/.. so that we can cache it
    export NPM_CONFIG_PREFIX=${TRAVIS_BUILD_DIR}/vendor/node_modules

    # Load UI build tasks
    source "$TCI_RUNNER_PWD/tasks/ui-tasks.sh"

    log_ok "Toolshedr UI Job DONE !!!" 
else
    log_warn "This Job should not call Toolshedr UI build script"
fi
exit 0
