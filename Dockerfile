#
# Nginx Dockerfile
#
# https://github.com/dockerfile/nginx
#

# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx

RUN rm -v /etc/nginx/nginx.conf

ADD files/nginx.conf /etc/nginx/nginx.conf

RUN mkdir /scripts && \
    mkdir /ssl && \
    mkdir /servers && \
    touch /firstrun

ADD files/start.sh /scripts/start.sh
ADD files/auto-key-gen.sh /scripts/auto-key-gen.sh
ADD files/openssl.conf /ssl/openssl.conf

RUN chmod +x /scripts/*.sh

# Attach volumes.
# VOLUME /etc/nginx/sites-enabled
VOLUME [ "/var/log/nginx" "/servers", "/ssl" ]

# Set working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
ENTRYPOINT ["/scripts/start.sh"]
