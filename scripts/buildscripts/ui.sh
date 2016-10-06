#!/bin/bash
set -ev

echo "Loaded Toolshedr UI build script!"

if [ "${TRAVIS_NODE_VERSION}" != "false" ]; then
	echo ${TRAVIS_NODE_VERSION}
else
    echo "UI called"
fi
