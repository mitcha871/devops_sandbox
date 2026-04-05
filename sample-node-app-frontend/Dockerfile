FROM node:lts-alpine3.23
WORKDIR /usr/src/app
COPY package*.json .
RUN ["npm", "ci", "--only=production"]
COPY *.js .
EXPOSE 8080
USER node
CMD ["npm", "start"]
