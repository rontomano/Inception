#!/bin/sh

if [ -f /var/www/wordpress/wp-config.php ]
then
	echo "Wordpress is already configured"
else
while ! mysqladmin ping -h mariadb -u mysql -pmysql --connect_timeout=2 --silent; do
	echo "Waiting for MariaDB to be ready..."
	sleep 1
done
# Create wp-config.php
wp config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'
# Welcome
wp core install		\
	--allow-root    \
	--path='/var/www/wordpress' \
	--url=${DOMAIN_NAME}        \
	--title=${WP_SITE_TITLE}    \
	--admin_user=${WP_ADMIN_USER}     \
	--admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_EMAIL} \
	--skip-email
# Create user
wp user create \
	--allow-root \
	--path='/var/www/wordpress' \
	${WP_USER} \
	${WP_USER_MAIL} \
	--user_pass=${WP_USER_PASS} \

# moving to path and config Redis
cd /var/www/wordpress
wp config set WP_REDIS_HOST redis --allow-root
wp config set WP_REDIS_PORT 6379 --raw --allow-root
wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
wp config set WP_REDIS_CLIENT phpredis --allow-root
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root
wp redis enable --allow-root

# Config debug
# wp config set WP_DEBUG true --allow-root
# wp config set WP_DEBUG_LOG true --allow-root
# wp config set WP_DEBUG_DISPLAY false --allow-root

#Done
echo "Wordpress is configured"
fi
exec "$@"
