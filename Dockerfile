FROM alpine:3.14.0@sha256:1775bebec23e1f3ce486989bfc9ff3c4e951690df84aa9f926497d82f2ffca9d

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
