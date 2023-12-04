FROM    alpine:3.17

RUN     apk update && apk upgrade && apk add hugo \
            git \
            shadow

# create new hugo site
RUN hugo new site /var/hugo/website \
 	&&     cd /var/hugo/website \
 	&&     git clone https://github.com/kaapiandcode/hugo-goa.git themes/goa \
 	&&     hugo new posts/presentation.md \
 	&&     hugo -b https://drontome.42.fr/website

COPY    ./conf/config.toml        /var/hugo/website/config.toml
COPY    conf/presentation.md    /var/hugo/website/content/posts/presentation.md


EXPOSE 3000

CMD     ["hugo", "server", \
         "--bind=0.0.0.0", \
         "--baseURL=https://drontome.42.fr/website", \
         "-p", "3000", \
         "--logFile=/dev/stdout", \
        "--appendPort=false"]
