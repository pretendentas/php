#!/bin/bash

if [ -f /var/www/html/composer.json ] && [ ! -d /var/www/html/vendor ]; then
   echo "[info] Composer install"
   composer install --working-dir=/var/www/html $COMPOSER_ARGS
fi


if [ ! -f /var/www/html/config.inc.php ]; then
    echo "[info] Copy default config"
    cp /var/www/html/config.inc.php.dist /var/www/html/config.inc.php
fi

chmod -R 777 /var/www/html/tmp
chmod -R 777 /var/www/html/log
chmod -R 777 /var/www/html/export
chmod -R 777 /var/www/html/out/pictures
chmod -R 777 /var/www/html/out/media
chmod -R 777 /var/www/html/out/upload