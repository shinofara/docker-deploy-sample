#!/bin/sh

APP_IMG_NAME=shinofara/nginx
APP_VHOST=192.168.33.99

# 同じタグで実行中のコンテナをリストアップ
CURRENT_CONTAINERS=`docker ps | grep $APP_IMG_NAME | awk '{print $1}'`
echo "[Running containers]"
echo "$CURRENT_CONTAINERS"

echo `date` > index.html

docker run \
    -d \
    -p 9000 \
    -v $(pwd)/index.html:/usr/share/nginx/html/index.html \
   $APP_IMG_NAME

#docker run -d -p 8080:80 shinofara/nginx:latest

# コンテナの情�を取得
NEW_ID=`docker ps -l -q`
NEW_ADDR=`docker port $NEW_ID 9000`
NEW_PORT=${NEW_ADDR#0.0.0.0:}
NEW_IP=`docker inspect --format="{{ .NetworkSettings.IPAddress }}" $NEW_ID`
echo "[New container info]"
echo "CONTAINER ID: ${NEW_ID}"
echo "IP: ${NEW_IP}"
echo "POERT: ${NEW_PORT}"

sleep 1

# NGINX用の設定ファイルを生成
echo "[Write new nginx config]"
cat <<EOF > /etc/nginx/conf.d/nginx-app.conf
upstream container-sentry { server 127.0.0.1:$NEW_PORT; }
server {
    listen   80;
    server_name $APP_VHOST;

    proxy_set_header   Host                 \$http_host;
    proxy_set_header   X-Real-IP            \$remote_addr;
    proxy_set_header   X-Forwarded-For      \$proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto    \$scheme;
    proxy_redirect     off;

    location / {
        proxy_set_header Host \$host;
        proxy_pass http://container-sentry;
        break;
    }
}
EOF

# NGINXをリロード
service nginx reload

# 古いコンテナをシャットダウン
echo "[Shutting down old containers]"
if [ -n "$CURRENT_CONTAINERS" ]; then
  docker kill $CURRENT_CONTAINERS
fi

echo "[Done]"
