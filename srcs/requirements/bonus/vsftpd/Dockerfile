#pull basic image
FROM alpine:3.17
#install vsftpd
RUN apk update && apk upgrade && \
    apk add vsftpd
#copy script
COPY tools/start_ftp.sh  /start_ftp.sh
RUN chmod +x /start_ftp.sh
#expose port
EXPOSE 21
#start vsftpd
WORKDIR /var/www/wordpress
CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
ENTRYPOINT [ "/bin/sh", "/start_ftp.sh"]
