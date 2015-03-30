FROM ubuntu:latest
MAINTAINER kiban-team

RUN apt-get install -y curl

# (1) nginxサイトが配布するPGPキーを追加
RUN curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

# (2) リポジトリを一覧に追加
RUN sh -c "echo 'deb http://nginx.org/packages/ubuntu/ trusty nginx' >> /etc/apt/sources.list"
RUN sh -c "echo 'deb-src http://nginx.org/packages/ubuntu/ trusty nginx' >> /etc/apt/sources.list"

# (3) アップデート後、nginxをインストール
RUN apt-get update
RUN apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf 

ADD default.conf /etc/nginx/conf.d/default.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]


# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"]

# Expose ports.
EXPOSE 9000
