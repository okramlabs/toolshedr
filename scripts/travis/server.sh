#!/usr/bin/env bash

set -e

echo "Loaded Toolshedr Server build script!"

if [ -n "${TRAVIS_PHP_VERSION+1}" ]; then
	echo ${TRAVIS_PHP_VERSION}
else
    echo "This Job should not call Toolshedr Server build script"
fi
