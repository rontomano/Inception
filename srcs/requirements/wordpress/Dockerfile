#pull basic image
FROM alpine:3.18
#set php version
ARG PHP_VERSION=81
#install php
#https://dev.to/vikbert/my-checklist-of-php-extensions-used-in-alpine-docker-image-1g3j
RUN apk update && apk add curl \
						php${PHP_VERSION} \
						php${PHP_VERSION}-fpm \
						php${PHP_VERSION}-session \
						php${PHP_VERSION}-mysqli \
						php${PHP_VERSION}-phar \
						php${PHP_VERSION}-zlib \
						php${PHP_VERSION}-json \
						php${PHP_VERSION}-dom \
						php${PHP_VERSION}-iconv \
						php${PHP_VERSION}-mbstring \
						php${PHP_VERSION}-openssl \
						php${PHP_VERSION}-curl \
						php${PHP_VERSION}-zip \
						php${PHP_VERSION}-xml \
						php${PHP_VERSION}-fileinfo \
						php${PHP_VERSION}-exif \
						php${PHP_VERSION}-cgi \
						php${PHP_VERSION}-redis \
						php${PHP_VERSION}-tokenizer \
						php${PHP_VERSION}-posix \
						php${PHP_VERSION}-ctype \
						php${PHP_VERSION}-intl \
						php${PHP_VERSION}-opcache \
						php${PHP_VERSION}-pcntl \
						mariadb-client \
						zip

#install wordpress
COPY tools/wordpress.zip /wordpress.zip
# RUN curl https://es.wordpress.org/wordpress-6.3.2-es_ES.zip -O wordpress.zip
RUN	unzip wordpress.zip -d /var/www/ \
	&& rm wordpress.zip \
	&& chown -R root:root /var/www/wordpress

#copy php config
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

#install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp-cli.phar \
	&& chmod +x /usr/local/bin/wp-cli.phar

RUN mkdir /run/php

COPY tools/config-wordpress.sh  /config-wordpress.sh

RUN chmod +x /config-wordpress.sh

EXPOSE 9000

CMD [ "php-fpm81", "-F" ]
ENTRYPOINT ["/config-wordpress.sh"]

