#!/usr/bin/env ash

set -e

TCP_CONFIG="/etc/nginx/tcpconf.d/tcp.stream"

SERVER_DNS=${SERVER_DNS:-"localhost"}

sed -i "s,SERVER_DNS,${SERVER_DNS},g" $TCP_CONFIG

nginx -g "daemon off;"
