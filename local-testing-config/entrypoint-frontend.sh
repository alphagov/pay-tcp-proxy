#!/bin/sh

set -e

apk add nginx-mod-stream

exec nginx -g 'daemon off;'
