#!/bin/sh

set -e

apk add nginx-mod-stream

PROXY_PROTOCOL=${PROXY_PROTOCOL:-off}
if [ "$PROXY_PROTOCOL" != "on" ] && [ "$PROXY_PROTOCOL" != "off" ]; then
  echo "Error: PROXY_PROTOCOL env var must either be 'on' or 'off'. It was $PROXY_PROTOCOL"
  exit 1
fi

NGINX_CONFIG="/etc/nginx/nginx.conf"
sed "s,PROXY_PROTOCOL,${PROXY_PROTOCOL},g" $NGINX_CONFIG.default > $NGINX_CONFIG

exec nginx -g 'daemon off;'
