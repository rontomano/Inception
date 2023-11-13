#pull basic image
FROM alpine:3.17
#install node.js
RUN apk update && apk upgrade && \
    apk add nodejs npm

#start project with template
RUN npx create-next-app --example blog drontome_blog
WORKDIR /drontome_blog
#copy config and pages
COPY ./config/next.config.js ./next.config.js
COPY ./tools/pages ./pages
#build project
RUN npm run build
#expose port and start project
EXPOSE 3000
CMD ["npm", "start"]
