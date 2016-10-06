#!/bin/bash
set -ev

echo "Loaded Toolshedr Server build script!"

if [ "${TRAVIS_PHP_VERSION}" != "false" ]; then
	echo ${TRAVIS_PHP_VERSION}
else
    echo "Server called"
fi
