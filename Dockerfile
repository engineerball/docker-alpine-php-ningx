FROM alpine:3.5
LABEL Maintainer="Teerapat Khunpech <ball@engineerball.com>" \
      Description="Lightweight container with Nginx 1.10 & PHP-FPM 7.1 based on Alpine Linux."

# Install packages from testing repo's
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-mcrypt php7-gd nginx \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/

# Install packages from stable repo's
RUN apk --no-cache add supervisor curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
#RUN mkdir -p /var/www/html
WORKDIR /var/www/html
#COPY src/ /var/www/html/
RUN chown -R nobody:nginx /var/log/php7 && chown -R nobody:nginx /var/lib/nginx/logs
USER nobody
EXPOSE 8080
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
