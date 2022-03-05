#!/bin/bash
# Script for install apache, mariadb, php and phpmyadmin for Raspberry pi OS
# Javier Lacave jclgranados@gmail.com

echo "Instalamos apache"
echo "-----"
apt install -y apache2
echo "-----"
echo ""
echo "Damos permisos y owner correctos"
echo "-----"
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -print -exec chmod 775 {} \;
find /var/www/html -type f -print -exec chmod 664 {} \;
usermod -a -G www-data nube
echo "-----"
echo ""
echo ""
echo "Instalamos mariadb"
echo "-----"
apt install -y mariadb-server
echo "-----"
echo ""
echo "Securizamos instalación, tendrás que responder algunas preguntas"
echo "-----"
mysql_secure_installation
echo "-----"
echo ""
echo ""
echo "Instalamos php"
echo "-----"
apt install php libapache2-mod-php php-mysql php-curl php-zip php-gd php-bcmath php-imagick php-gmp php-intl
echo "-----"
echo ""
echo "Reiniciamos apache"
echo "-----"
systemctl restart apache2
echo '<?php phpinfo(); ?>' > /var/www/html/info.php
chown www-data. /var/www/html/info.php
echo ""
echo ""
echo "Instalamos phpmyadmin"
echo "-----"
apt install -y phpmyadmin
echo "-----"
echo ""
echo "Instalamos certbot"
apt-get install python3-certbot-apache
certbot --authenticator webroot --installer apache
