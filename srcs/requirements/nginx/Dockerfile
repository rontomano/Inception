#pull basic image
FROM alpine:3.18
#install nginx and openssl
RUN apk update && apk add nginx openssl
#create directory for storing certificate and key
RUN mkdir -p /etc/nginx/ssl
#generate certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42Madrid/CN=drontome" \
	> /dev/null 2>&1
#copy nginx config file
COPY conf/nginx.conf /etc/nginx/nginx.conf
#open https port
EXPOSE	443
#start nginx
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
