#!/bin/sh

cp -f /etc/php5/fpm/php.ini .
cp -f /etc/nginx/sites-available/owncloud .
cp -f /etc/nginx/nginx.conf .
cp -f /etc/nginx/sites-available/default .

curl "http://donner-online.ch/dokuwiki/doku.php?do=export_code&id=installation_de_nginx&codeblock=0" > install.sh

