FROM alpine:3.18


RUN     apk update && apk upgrade && apk add hugo \
            git \
            shadow

# create new hugo site
RUN hugo new site /var/hugo/website \
        &&     cd /var/hugo/website \
        &&     git clone https://github.com/vaga/hugo-theme-m10c /var/hugo/website/themes/m10c \
        &&     hugo new /var/hugo/website/content/posts/presentation.md\
        &&     hugo -b https://drontome.42.fr/website

COPY    ./conf/config.toml        /var/hugo/website/config.toml
COPY    ./conf/presentation.md    /var/hugo/website/content/posts/presentation.md


EXPOSE 3000

WORKDIR /var/hugo/website

CMD     ["hugo", "server", \
         "--bind=0.0.0.0", \
         "--baseURL=https://drontome.42.fr/website", \
         "-p", "3000", \
         "--logFile=/dev/stdout", \
        "--appendPort=false"]
