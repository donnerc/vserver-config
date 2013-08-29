#!/bin/sh

cp -f php.ini /etc/php5/fpm/
cp -f owncloud /etc/nginx/sites-available/
cp -f nginx.conf /etc/nginx/nginx.conf
cp -f default /etc/nginx/sites-available/

service nginx restart && service php5-fpm restart

