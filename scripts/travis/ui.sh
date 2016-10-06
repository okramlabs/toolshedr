#!/usr/bin/env bash

set -e

echo "Loaded Toolshedr UI build script!"

if [ "${TRAVIS_NODE_VERSION+1}" ]; then
    export NPM_CONFIG_PREFIX=${TRAVIS_BUILD_DIR}/vendor/node_modules
	echo ${TRAVIS_NODE_VERSION}
else
    echo "This Job should not call Toolshedr UI build script"
fi
