FROM php:7.1.0RC5-fpm-alpine
MAINTAINER Marko Kungla <marko@okramlabs.com>

# Prepare the Toolshedr Devel Image
RUN apk add --no-cache --virtual .tmp-deps \
    wget unzip ca-certificates && \

    # Add presistent dependencies
    apk add --update \
    bash nginx && \

    # Swagger Editor
    mkdir -p /swagger-web/ && \
    cd /usr/src && \
    wget https://github.com/swagger-api/swagger-editor/releases/download/v2.10.4/swagger-editor.zip && \
    unzip swagger-editor.zip && \
    rm swagger-editor.zip && \
    mv /usr/src/swagger-editor/* /swagger-web && \


    # Remove temp dependencies
    apk del .tmp-deps

ADD init.sh /init.sh

RUN chown -Rf nginx:www-data /var/www/

WORKDIR /var/www

CMD bash -C '/init.sh';'bash'
EXPOSE 80