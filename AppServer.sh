#!/bin/bash
# Install Apache and PHP
sudo /usr/bin/apt-get -y update
sudo /usr/bin/apt-get -y install apache2 php5 php5-mysql php5-gdcm php-xml-rpc php5-mcrypt unzip wget mariadb-client
# Download and install Demo app
sudo /usr/bin/wget -O /var/www/html/config.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/config.php
sudo /usr/bin/wget -O /var/www/html/create.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/create.php
sudo /usr/bin/wget -O /var/www/html/delete.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/delete.php
sudo /usr/bin/wget -O /var/www/html/error.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/error.php
sudo /usr/bin/wget -O /var/www/html/index.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/index.php
sudo /usr/bin/wget -O /var/www/html/read.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/read.php
sudo /usr/bin/wget -O /var/www/html/update.php https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/update.php
sudo /bin/sed -i "s@DBName@$demo_app_mysql_database@" /var/www/html/config.php
sudo /bin/sed -i "s@DBUser@$demo_app_mysql_user@" /var/www/html/config.php
sudo /bin/sed -i "s@DBPassword@$demo_app_mysql_password@" /var/www/html/config.php
sudo /bin/sed -i "s@DBServer@$demo_app_mysql_server@" /var/www/html/config.php
sudo /bin/sed -i "s@HOSTNAME@$hostname@" /var/www/html/index.php
/usr/bin/wget -O /tmp/employees.sql https://raw.githubusercontent.com/sammcgeown/vRA-3-Tier-Application/master/app/employees.sql
/usr/bin/mysql -u "$demo_app_mysql_user" -p"$demo_app_mysql_password" $demo_app_mysql_database -h $demo_app_mysql_server < /tmp/employees.sql
# Remove index.html
sudo rm -f /var/www/html/index.html
# Restart Apache
sudo service apache2 restart