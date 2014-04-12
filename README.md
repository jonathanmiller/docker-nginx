# Nginx Dockerfile

This repository contains a **Dockerfile** of [Nginx](http://nginx.org/)
for [Docker](https://www.docker.io/)'s [trusted build](https://index.docker.io/u/dockerfile/nginx/)
published to the public [Docker Registry](https://index.docker.io/).

## Dependencies

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)

## Docker Image Creation

1. Install [Docker](https://www.docker.io/).
2. Build the image with either
  1. docker build -t="jonathanmiller/docker-nginx" github.com/jonathanmiller/docker-nginx
  2. Manually with Git clone
    1. git clone https://github.com/jonathanmiller/docker-nginx
    2. cd docker-nginx
    3. docker build .

## Usage

Basic Execution

```
docker run -d -p 80:80 jonathanmiller/docker-nginx
```

With SSL

```
docker run -d -p 80:80 -p 443:443 jonathanmiller/docker-nginx
```

Attach Log and Server Configuration Volumes
```
docker run -d \
 -p 80:80 \
 -p 443:443 \
 -v <log-dir>:/var/log/nginx \
 -v <sites-enabled-dir>:/servers \
 jonathanmiller/docker-nginx
```
