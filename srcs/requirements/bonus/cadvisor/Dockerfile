#pull basic image
FROM alpine:3.18
#install redis
RUN apk update && apk add wget
#download cadvisor
RUN wget https://github.com/google/cadvisor/releases/download/v0.47.2/cadvisor-v0.47.2-linux-amd64 -O /usr/bin/cadvisor && \
	chmod +x /usr/bin/cadvisor
#expose port
EXPOSE 8080
#start cadvisor
CMD [ "/usr/bin/cadvisor" ]
