#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

# Start the job
message "Loaded Toolshedr UI build script!" $Color_LightGreen

if [ "${TRAVIS_NODE_VERSION+1}" ]; then
	message "Starting build of Toolshedr UI with node ${TRAVIS_NODE_VERSION}" $Color_LightGreen
    message $(pwd) $Color_LightGray

    # Set node_modules path to vendor/.. so that we can cache it
    export NPM_CONFIG_PREFIX=${TRAVIS_BUILD_DIR}/vendor/node_modules

    message "Toolshedr UI Job DONE !!!" $Color_Green
else
    message "This Job should not call Toolshedr UI build script" $Color_LightBlue
fi
exit 0