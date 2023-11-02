#pull basic image
FROM alpine:3.17
#install wget and php
RUN apk update && apk add wget \
					php \
					php-fpm \
					php-mysqli \
					php-phar \
					php-iconv \
					php-mbstring \
					mariadb-client \
					zip
#install symfony
RUN apk add curl bash
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.alpine.sh' | bash
RUN apk add symfony-cli
# #install wordpress
COPY tools/wordpress.zip /wordpress.zip
# RUN wget https://es.wordpress.org/wordpress-6.3.2-es_ES.zip -O wordpress.zip
RUN	unzip wordpress.zip -d /var/www/ \
	&& rm wordpress.zip \
	&& chown -R root:root /var/www/wordpress
#check for nginx:nginx instead of root:root

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

