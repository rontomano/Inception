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
wp-cli.phar config create	--allow-root \
					--dbname=$MYSQL_DATABASE \
					--dbuser=$MYSQL_USER \
					--dbpass=$MYSQL_PASSWORD \
					--dbhost=mariadb:3306 --path='/var/www/wordpress'
# Welcome
wp-cli.phar core install		\
	--allow-root    \
	--path='/var/www/wordpress' \
	--url=${WP_SITE_URL}        \
	--title=${WP_SITE_TITLE}    \
	--admin_user=${WP_ADMIN_USER}     \
	--admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_EMAIL}
# Create user
wp-cli.phar user create \
	--allow-root \
	--path='/var/www/wordpress' \
	${WP_USER} \
	${WP_USER_MAIL} \
	--user_pass=${WP_USER_PASS}
echo "Wordpress is configured"
fi
exec "$@"
