#!/usr/bin/env bash

sudo apt-get update --fix-missing -y && sudo apt-get install -qq mysql-server

green() {
  echo -e '\e[32m'$1'\e[m';
}

DBNAME=demo1
DBUSER=demo1
DBPASSWD=1Q2W3E4r5tzxc@
ROOTPASSWD=1Q2W3E4r5tzxc@

debconf-set-selections <<< "mysql-server mysql-server/root_password password $ROOTPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $ROOTPASSWD"

readonly MYSQL=`which mysql`

# Construct the MySQL query
readonly Q1="CREATE DATABASE IF NOT EXISTS $DBNAME;"
readonly Q2="CREATE USER IF NOT EXISTS '$DBUSER'@'192.168.33.%' IDENTIFIED BY '$DBPASSWD';"
readonly Q3="GRANT ALL ON $DBNAME.* TO '$DBUSER'@'192.168.33.%';"
readonly Q4="FLUSH PRIVILEGES;"
readonly SQL="${Q1}${Q2}${Q3}${Q4}"

# Run the actual command
$MYSQL -uroot -p$ROOTPASSWD -e "$SQL"

# Let the user know the database was created
green "Database $DBNAME and user $DBUSER created with a password you choose"

sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

#mysql -uroot -p$ROOTPASSWD -e "DROP DATABASE $DBNAME;"
#mysql -uroot -p$ROOTPASSWD -e "DROP USER $DBUSER;"

sudo service mysql restart