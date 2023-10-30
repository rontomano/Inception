#!/bin/sh

#Start mariadb daemon and wait until it's ready
/usr/bin/mysqld_safe & 2&>1 > /dev/null
while ! mysqladmin ping > /dev/null 2&>1; do
  sleep 1
done

#check if database already exists
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
#automated mysql_secure_installation
mysqladmin password $MYSQL_ROOT_PASSWORD
mysql --user=root -p$MYSQL_ROOT_PASSWORD <<- EOF
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	FLUSH PRIVILEGES;
EOF
#create database
mysql --user=root -p$MYSQL_ROOT_PASSWORD <<- EOF
	CREATE DATABASE $MYSQL_DATABASE;
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	FLUSH PRIVILEGES;
EOF
fi
while pkill mariadbd; do
  sleep 1
done
exec "$@"

