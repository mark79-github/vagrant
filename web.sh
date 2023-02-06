#!/bin/bash

echo "## Add hosts ..."
echo "192.168.34.99 web.martin.bg web" >> /etc/hosts
echo "192.168.34.100 db.martin.bg db" >> /etc/hosts

echo "## Updating and upgrading system ..."
sudo apt-get -y update
sudo apt-get -y upgrade

echo "## Installing needed software (apache2, php, libapache2-mod-php, php-mysql and git) ..."
sudo apt-get -y install apache2 php libapache2-mod-php php-mysql git ufw 

echo "## Starting web server ..."
sudo service apache2 start

echo "## Opening http ports (HTTP 80/tcp, HTTPS 443/tcp) ..."
sudo ufw allow http
sudo ufw enable

echo "## Cloning data repository ..."
sudo git clone https://github.com/shekeriev/bgapp.git

echo "## Coping needed files to web server default directory ..."
cp bgapp/web/* /var/www/html
sudo rm -rf bgapp

if [ -f /var/www/html/index.html ]; then
    echo "## Rename default web server index file to load index.php ...";
    sudo mv /var/www/html/index.html /var/www/html/original_index.html;
fi
