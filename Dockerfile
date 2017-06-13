FROM php:5.6-fpm
LABEL maintainer "karolis@pretendentas.lt"

WORKDIR /var/www/html

VOLUME /var/www/html
EXPOSE 9000

COPY docker-entrypoint.sh /usr/local/bin/
COPY init.sh /var/www/html/init.sh

RUN apt-get update && apt-get install -y \
        zip \
        git \
        libxml2-dev \
        libjpeg-dev \
        libpng12-dev \
    && docker-php-ext-configure gd --with-png-dir=/usr/ --with-jpeg-dir=/usr/ \
    && docker-php-ext-install -j$(nproc) bcmath gd mysqli opcache soap

RUN mkdir -p /var/lib/php/session \
    && mkdir -p /var/lib/php/wsdlcache \
    && chown -R www-data:www-data /var/lib/php/session \
    && chown -R www-data:www-data /var/lib/php/wsdlcache
    # && chmod +x /docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

ENV GITHUB_TOKEN 87dc62834bd4267a86c4602b4efd381cfb6c8f14

RUN curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/bin \
        --filename=composer \
    && composer config -g github-oauth.github.com $GITHUB_TOKEN

CMD ["php-fpm"]
