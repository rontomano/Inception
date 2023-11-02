#!/bin/sh

if [ ! -d "/var/lib/mysql/mysql" ]; then
		#run initial config
		mkdir -p /var/run/mysqld
		chown -R mysql:mysql /var/run/mysqld
		mkdir -p /var/lib/mysql
        chown -R mysql:mysql /var/lib/mysql
		mysql_install_db --user=mysql --datadir=/var/lib/mysql > dev/null 2>&1
fi

#check if database already exists
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	cat > /tmp/create.sql <<- EOF
		FLUSH PRIVILEGES;
		DELETE FROM mysql.user WHERE User='';
		DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
		DROP DATABASE IF EXISTS test;
		DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
		ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
		CREATE DATABASE $MYSQL_DATABASE;
		CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
		GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
		FLUSH PRIVILEGES;
	EOF
	mysqld --user=mysql --bootstrap --silent < /tmp/create.sql
fi
exec "$@"

