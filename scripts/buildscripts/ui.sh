#!/bin/bash
set -ev
if [ "${TRAVIS_NODE_VERSION}" != "false" ]; then
	echo ${TRAVIS_NODE_VERSION}
else
    echo "UI called"
fi
