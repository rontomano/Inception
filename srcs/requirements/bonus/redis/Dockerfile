#pull basic image
FROM alpine:3.17
#install redis
RUN apk update && apk add redis
#change .conf to avoid bind localhost, set maxmemory to 20mb and its policy to LRU (Keeps most recently used keys; removes least recently used)
RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis.conf && \
	sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g" /etc/redis.conf && \
	sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lru|g" /etc/redis.conf
#open redis port
EXPOSE 6379
#start redis
ENTRYPOINT [ "redis-server", "/etc/redis.conf", "--protected-mode", "no"]
