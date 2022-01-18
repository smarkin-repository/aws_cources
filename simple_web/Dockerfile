FROM node:13.12.0-alpine as builder

ARG SERVER_PORT

WORKDIR /usr/src/app

ENV PATH /usr/src/app/node_modules/.bin:$PATH
ENV SERVER_PORT $SERVER_PORT
COPY package*.json ./

RUN npm install

COPY . .

# Build the project and copy the files
RUN npm run build


FROM nginx:1.16.0-alpine

RUN rm -rf /usr/share/nginx/html/*
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY --from=builder  /usr/src/app/build /usr/share/nginx/html

EXPOSE $SERVER_PORT

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]