#pull basic image
FROM alpine:3.18
#install vsftpd
RUN apk update && apk upgrade && \
    apk add vsftpd
#copy script
COPY tools/start_ftp.sh  /start_ftp.sh
RUN chmod +x /start_ftp.sh
RUN mkdir -p /var/run/vsftpd && touch /var/run/vsftpd/vsftpd.pid
#expose port
EXPOSE 21
#start vsftpd
WORKDIR /var/www/wordpress
CMD [ "/usr/sbin/vsftpd", "/etc/vsftpd/vsftpd.conf"]
ENTRYPOINT [ "/start_ftp.sh"]
