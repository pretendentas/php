#!/bin/bash
set -e

if [ -f var/wwww/html/docker/init.sh ]; then
    sleep 5 && echo "[info] Running /var/www/html/init.sh script" && sh /var/www/html/init.sh &
fi