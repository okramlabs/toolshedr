#!/bin/bash
set -ev
if [ "${TRAVIS_PHP_VERSION}" != "false" ]; then
	echo ${TRAVIS_PHP_VERSION}
else
    echo "Server called"
fi
