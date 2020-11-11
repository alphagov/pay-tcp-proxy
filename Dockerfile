FROM alpine:3.12.0@sha256:185518070891758909c9f839cf4ca393ee977ac378609f700f60a771a2dfe321

USER root

RUN addgroup -S nginx \
    && adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx

RUN ["apk", "add", "--no-cache", "nginx", "nginx-mod-stream"]

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir /app && mkdir /etc/nginx/tcpconf.d && chown -R nginx:nginx /etc/nginx
ADD src/docker-startup.sh /app
ADD src/files/authorized_ip /etc/nginx/
ADD src/files/tcp.stream /etc/nginx/tcpconf.d
COPY src/files/nginx_conf /etc/nginx/nginx.conf

EXPOSE 443

WORKDIR /app

CMD ./docker-startup.sh
