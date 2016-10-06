#!/bin/bash
set -ev

echo "Loaded Toolshedr UI build script!"

if [ "${TRAVIS_NODE_VERSION}" != "false" ]; then
    export NPM_CONFIG_PREFIX=${TRAVIS_BUILD_DIR}/vendor/node_modules
	echo ${TRAVIS_NODE_VERSION}
else
    echo "UI called"
fi
