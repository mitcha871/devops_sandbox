FROM node:lts-alpine3.23 AS build-stage
WORKDIR /usr/src/app
COPY package*.json .
RUN ["npm", "ci", "--only=production"]
COPY app.js .
USER node
EXPOSE 8080
CMD ["npm", "start"]
