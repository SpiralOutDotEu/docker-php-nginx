FROM alpine:3.8
LABEL Maintainer="Tim de Pater <code@trafex.nl>" \
      Description="Lightweight container with Nginx 1.14 & PHP-FPM 7.2 based on Alpine Linux."

# Install packages
RUN apk --no-cache add php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www

VOLUME /var/www

EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
