#pull basic image
FROM alpine:3.18
#set php version
ARG PHP_VERSION=81
#https://dev.to/vikbert/my-checklist-of-php-extensions-used-in-alpine-docker-image-1g3j
#install php
RUN apk update && apk add wget \
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
# download adminer
RUN mkdir -p /var/www/html && \
	wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php  && \
	chown -R root:root /var/www/html
#copy php config
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
#expose port
EXPOSE 4242
#start adminer
CMD [ "php-fpm81", "-F" ]
