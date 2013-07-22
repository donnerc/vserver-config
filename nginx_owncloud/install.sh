#!/usr/bin/sh

nginx_path=/usr/share/nginx/
owncloud_version=5.0.9

# installation de nginx sous ubuntu 12.04 server
sudo apt-get install nginx php5-fpm php5 php5-json php5-gd php5-sqlite curl libcurl3 libcurl3-dev php5-curl php5-common php-xml-parser sqlite php-apc

# configuration de nginx

mkdir /etc/nginx/certs/

cp -f nginx.conf /etc/nginx/

cp -f default  /etc/nginx/sites-available/
cp -f owncloud /etc/nginx/sites-available/

ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
ln -sf /etc/nginx/sites-available/owncloud/etc/nginx/sites-enabled/

# configuration de php-fpm
cp -f php.ini /etc/php5/fpm/

# création dossier sécurisé pour HTTPS
mkdir -p $nginx_path/secure/owncloud

cd $nginx_path/secure/owncloud

wget http://download.owncloud.org/community/owncloud-$owncloud_version.tar.bz2
tar xjf owncloud-$owncloud_version.tar.bz2

chown www-data:www-data -R $nginx_path/secure
chown www-data:www-data -R $nginx_path/www

# création des certificats SSL
echo "Création des certificats SSL pour utiliser la connexion sécurisée pour owncloud"

cd /etc/nginx/certs
openssl genrsa -out server.key 2048
openssl genrsa -des3 -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt


# redémarrage des services pour prendre en compte les modifications
service nginx restart
service php5-fpm restart

echo "Pour terminer d'installer owncloud, visiter 'https://www.donner-online.ch/owncloud/'"
echo "Pour tester l'installation de Nginx, visiter 'http://www.donner-online.ch'"