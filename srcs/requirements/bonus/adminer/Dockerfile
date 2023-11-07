#pull basic image
FROM alpine:3.17
#set php version
ARG PHP_VERSION=81
#https://dev.to/vikbert/my-checklist-of-php-extensions-used-in-alpine-docker-image-1g3j
#install wget and php
RUN apk update && apk add wget \
				mariadb-client \
				php${PHP_VERSION} \
				php${PHP_VERSION}-fpm \
				php${PHP_VERSION}-common \
				php${PHP_VERSION}-session \
				php${PHP_VERSION}-iconv \
				php${PHP_VERSION}-json \
				php${PHP_VERSION}-gd \
				php${PHP_VERSION}-curl \
				php${PHP_VERSION}-xml \
				php${PHP_VERSION}-mysqli \
				php${PHP_VERSION}-imap \
				php${PHP_VERSION}-pdo \
				php${PHP_VERSION}-pdo_mysql \
				php${PHP_VERSION}-soap \
				php${PHP_VERSION}-posix \
				php${PHP_VERSION}-gettext \
				php${PHP_VERSION}-ldap \
				php${PHP_VERSION}-ctype \
				php${PHP_VERSION}-dom \
				php${PHP_VERSION}-simplexml
# download adminer
RUN mkdir -p /var/www/html && \
	wget -O /var/www/html/index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php  && \
	chown -R root:root /var/www/html
#copy script
COPY tools/start_adminer.sh  /start_adminer.sh
RUN chmod +x /start_adminer.sh
#expose port
EXPOSE 8080
#start adminer
CMD [ "php", "-S", "0.0.0.0:8080", "-t", "/var/www/html" ]
ENTRYPOINT [ "/start_adminer.sh" ]

