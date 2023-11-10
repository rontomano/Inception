#pull basic image
FROM alpine:3.17
#install node.js
RUN apk update && apk upgrade && \
    apk add nodejs npm

#start website
# RUN npx create-next-app static-website
RUN npx create-next-app --example blog drontome_blog
# RUN npx create-next-app static-website --use-npm --js --no-eslint --no-tailwind --no-src-dir --app --import-alias "@/*"
WORKDIR /drontome_blog
RUN npm run build
EXPOSE 3000
CMD ["npm", "start"]
