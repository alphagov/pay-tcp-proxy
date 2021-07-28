#!/usr/bin/env ash

set -e

TCP_CONFIG="/etc/nginx/tcpconf.d/tcp.stream"

SERVER_DNS=${SERVER_DNS:-"localhost"}
sed -i "s,SERVER_DNS,${SERVER_DNS},g" $TCP_CONFIG

PROXY_PROTOCOL=${PROXY_PROTOCOL:-off}
if [ "$PROXY_PROTOCOL" = "on" ]; then
  sed -i "s,PROXY_PROTOCOL,proxy_protocol,g" $TCP_CONFIG
  # shellcheck disable=SC2016
  sed -i 's,REMOTE_ADDR_LOG_FORMAT,$proxy_protocol_addr:$proxy_protocol_port $proxy_protocol_server_addr,g' $TCP_CONFIG
elif [ "$PROXY_PROTOCOL" = "off" ]; then
  sed -i "s,PROXY_PROTOCOL,,g" $TCP_CONFIG
  # shellcheck disable=SC2016
  sed -i 's,REMOTE_ADDR_LOG_FORMAT,$remote_addr,g' $TCP_CONFIG
else
  echo "Error: PROXY_PROTOCOL env var must either be 'on' or 'off'. It was $PROXY_PROTOCOL"
  exit 1
fi

nginx -g "daemon off;"
