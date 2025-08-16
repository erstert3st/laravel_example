FROM shinsenter/php:8.4-fpm-apache
# ENV PHP_LISTEN="0.0.0.0:9000"

# RUN sed -i 's|^env-default PHP_LISTEN .*|env-default PHP_LISTEN "0.0.0.0:9000"|' /path/to/env-file \
#     && sed -i 's|^env-default PHP_LISTEN_GROUP .*|env-default PHP_LISTEN_GROUP ""|' /path/to/env-file \
#     && sed -i 's|^env-default PHP_LISTEN_OWNER .*|env-default PHP_LISTEN_OWNER ""|' /path/to/env-file \
#     && sed -i 's|^env-default PHP_LISTEN_MODE .*|env-default PHP_LISTEN_MODE ""|' /path/to/env-file

# ----------------------------
# 2️⃣ Apache config auf TCP ändern
# ----------------------------
RUN sed -i 's|proxy:unix:${PHP_LISTEN}|fcgi://127.0.0.1:9000|' /etc/apache2/sites-available/*.conf \
    || echo "Apache config file not found, check path"
RUN sed -i 's|proxy:unix:${PHP_LISTEN}|fcgi://127.0.0.1:9000|' /etc/apache2/apache2.conf
RUN sed -i '/^listen\./d' /usr/local/etc/php-fpm.d/zz-docker.conf
RUN ls /usr/local/etc/php-fpm.d/ > /tmp/php-fpm.d.files
# ----------------------------
# 3️⃣ Optional: PHP-FPM pool config anpassen
# ----------------------------
RUN sed -i 's|listen = /run/php-fpm.sock|listen = 0.0.0.0:9000|' /usr/local/etc/php-fpm.d/www.conf

RUN apt update && apt install -y iproute2 curl net-tools

COPY web /var/www/html/
ENTRYPOINT []
CMD ["docker-php-entrypoint"]