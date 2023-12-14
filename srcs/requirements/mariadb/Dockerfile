#pull basic image
FROM alpine:3.18
#install mariadb
RUN apk update && apk add mariadb mariadb-client

#copy config files and entrypoint
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/start-mariadb.sh /start-mariadb.sh
RUN chmod +x /start-mariadb.sh
#Expose port
EXPOSE 3306
#start script
CMD  ["mysqld_safe", "--silent-startup"]
ENTRYPOINT ["/start-mariadb.sh"]
