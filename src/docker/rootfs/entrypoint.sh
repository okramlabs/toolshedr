#!/bin/bash

set -e
trap "echo TRAPed signal" HUP INT QUIT TERM

echo "\n"
echo "starting php-fpm"
su-exec root php-fpm

echo "starting sshd"
su-exec root /usr/sbin/sshd

echo "starting nginx"
su-exec root nginx -g 'daemon off;'



exec "$@"