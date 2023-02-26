# pull official base image
FROM node:19-alpine

# set working directory
WORKDIR /app

# ensure executables created inside container can be found
ENV PATH /app/node_modules/.bin:$PATH

# install build dependencies for mozjpeg
ENV BUILD_DEPS libc6-compat autoconf automake libtool make tiff jpeg zlib zlib-dev pkgconf nasm file gcc musl-dev
RUN apk add --no-cache --virtual .deps $BUILD_DEPS

# install app dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm install

# remove build dependencies
RUN apk del .deps

# add app
COPY . ./

# start app
CMD ["npm", "start"]