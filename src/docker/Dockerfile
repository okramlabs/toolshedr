######################################################################
# @project  Toolshedr Development Environment
# @uthor    Marko Kungla <marko@okramlabs.com>
# @date     22 November 2016
######################################################################

# Use official Alpine image
FROM alpine:edge
MAINTAINER Marko Kungla <marko@okramlabs.com>

# Build arguments
ARG TOOLSHEDR_VERSION="0.4.0"
ARG TOOLSHEDR_RELEASE_DATE="22.11.2016"
ARG TOOLSHEDR_SWAGGER_EDITOR_VERSION="v2.10.4"

# Image labels
LABEL com.okramlabs.toolshedr.version=$TOOLSHEDR_VERSION
LABEL com.example.release-date=$TOOLSHEDR_RELEASE_DATE


######################################################################
# PERSISTENT Dependencies
######################################################################
ENV PERSISTENT_DEPS \
    # Add system packages
    openrc \
    nginx \
    bash \
    su-exec \
    wget \
    unzip \
    gnupg \
    openssl \
    rsync \
    openssh \

    # Add PHP packages
    php7 \
    php7-fpm \
    php7-session \
    php7-ctype \
    php7-json \
    php7-sockets \
    php7-zlib \
    php7-mcrypt \
    php7-sqlite3

######################################################################
# PERSISTENT Dependencies
######################################################################
ENV BUILD_DEPS \
    ca-certificates

######################################################################
# Add root filesystem
######################################################################
ADD rootfs /

######################################################################
# Setup and configure Toolshedr Development Environment
######################################################################
RUN set -xe \
    # Add presistent dependecies
    && apk add --update --no-cache $PERSISTENT_DEPS \

    # add build dependecies
    && apk add --no-cache --virtual .build-deps $BUILD_DEPS \

    # Add Toolshedr user
    && adduser -D -u 1000 -h /var/www/toolshedr toolshedr \
    && echo "toolshedr:toolshedr" | chpasswd \

    # Get Swagger Editor
    && mkdir -p /usr/src \
    && cd /usr/src \
    && wget https://github.com/swagger-api/swagger-editor/releases/download/$TOOLSHEDR_SWAGGER_EDITOR_VERSION/swagger-editor.zip \
    && unzip swagger-editor.zip \
    && rm swagger-editor.zip \
    && rsync -acxzP --ignore-existing /usr/src/swagger-editor/* /var/www/toolshedr/public/swagger-editor \

    # Make entrypoint executable
    && chmod +x /entrypoint.sh \

    # Create symlinks PHP -> PHP7
    && ln -sf /usr/bin/php7 /usr/bin/php \
    && ln -sf /usr/sbin/php-fpm7 /usr/bin/php-fpm \

    # nginx config
    && mkdir -p /run/nginx \

    # Fix permissions
    && chmod u+s /sbin/su-exec \
    && chown -R toolshedr:toolshedr /var/www/toolshedr \

    # Alpine configuration
    && rc-update add sshd \
    && rc-status  \

    # Configure SSH
    && ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa \
    && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa \
    && ssh-keygen -f /etc/ssh/ssh_host_ed25519_key -N '' -t ed25519 \

    && mkdir -p /var/run/sshd \

    # Output
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \

    # Clean UP
    && rm -rf \
        /usr/include/php7 \
        /usr/lib/php7/build \
        /usr/lib/php7/modules/*.a \
        /var/cache/apk/* \
        /tmp/* \

    # Remove build dependencies
    && apk del .build-deps

# User who we run as
USER toolshedr

######################################################################
# Layer constructed by Toolshedr User
######################################################################
RUN set -xe \
    ssh-keygen -A

ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /var/www/toolshedr

EXPOSE 80 22
