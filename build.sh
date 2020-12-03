#! /bin/bash

docker build . -f .docker/Dockerfile.nginx -t local/ubi:8.1-nginx &&  \
docker build . -f .docker/Dockerfile.build -t local/node:12-alpine &&  \
docker run --rm -v "`pwd`:/app:rw" -w "/app" local/node:12-alpine npm install && \
docker run --rm -v "`pwd`:/app:rw" -w "/app" local/node:12-alpine npm run build