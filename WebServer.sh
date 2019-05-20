#!/bin/bash
# Install nginx
sudo /usr/bin/apt-get -y update
sudo /usr/bin/apt-get -y install nginx
# Download the reverse proxy configuration
sudo /usr/bin/wget -O /etc/nginx/conf.d/proxy.conf https://raw.githubusercontent.com/mcleodj/vRA-3-Tier-Application/master/config/proxy.nginx.conf
sudo /bin/sed -i "s@SERVERNAME@$web_server_name@" /etc/nginx/conf.d/proxy.conf
sudo /bin/sed -i "s@APPTIER@$app_server_name@" /etc/nginx/conf.d/proxy.conf
# Create the SSL folder
sudo /bin/mkdir /etc/nginx/ssl
# Download the proxy SSL conf
sudo /usr/bin/wget -O /etc/nginx/ssl/proxy.conf https://raw.githubusercontent.com/mcleodj/vRA-3-Tier-Application/master/config/proxy.ssl.conf
sudo /bin/sed -i "s@WEBSERVERNAME@$web_server_name@" /etc/nginx/ssl/proxy.conf
# Generate SSL keys
sudo /usr/bin/openssl req -x509 -nodes -days 1825 -newkey rsa:2048 -keyout /etc/nginx/ssl/proxy.key -out /etc/nginx/ssl/proxy.pem -config /etc/nginx/ssl/proxy.conf
# Start and enable nginx
sudo service nginx restart