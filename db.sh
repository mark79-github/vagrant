#!/bin/bash

echo "## Add hosts ..."
echo "192.168.34.99 web.martin.bg web" >> /etc/hosts
echo "192.168.34.100 db.martin.bg db" >> /etc/hosts

echo "## Updating and upgrading system ..."
sudo apt-get -y update
sudo apt-get -y upgrade

echo "## Installing needed software (mariadb mariadb-server) ..."
sudo apt-get -y install mariadb-server git ufw

echo "## Starting database server ..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

echo "## Configurating remote access to database server ..."
sudo sed -i 's/bind-address/#bind-address/g' /etc/mysql/mariadb.conf.d/50-server.cnf

echo "## Restarting database service ..."
sudo systemctl restart mariadb.service

echo "## Opening firewall port (3306) ..."
sudo ufw allow 3306/tcp
sudo ufw enable

echo "## Cloning data repository ..."
sudo git clone https://github.com/shekeriev/bgapp.git

echo "## Creating the database ..."
cd bgapp/db/
sudo mysql -u root < db_setup.sql
cd ../..
sudo rm -rf bgapp

