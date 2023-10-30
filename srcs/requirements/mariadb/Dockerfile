#pull basic image
FROM alpine:3.17
#install mariadb
RUN apk update && apk add mariadb mariadb-client
#run initial config
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql > dev/null 2>&1

#NOT NECESSARY WITH SAFE
	RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

#copy config files and entrypoint
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/mariadb.sh /start-mariadb.sh
RUN chmod +x /start-mariadb.sh
#Expose port
EXPOSE 3306
#start script
CMD  ["mariadbd"]
ENTRYPOINT ["/start-mariadb.sh"]
