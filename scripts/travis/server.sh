#!/bin/bash

set -e
TCI_RUNNER_PWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Import dependencies
source "$TCI_RUNNER_PWD/../helpers/colors.sh"

# Start the job
message "Loaded Toolshedr Server build script!" $Color_LightGreen

if [ -n "${TRAVIS_PHP_VERSION+1}" ]; then
	message "Starting build of Toolshedr Server with PHP ${TRAVIS_PHP_VERSION}" $Color_LightGreen
	message $(pwd) $Color_LightGray

	message "Toolshedr Server Job DONE !!!" $Color_Green
else
    message "This Job should not call Toolshedr Server build script" $Color_LightBlue
fi
exit 0