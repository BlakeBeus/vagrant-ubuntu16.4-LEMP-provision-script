#!/bin/bash

#THIS SCRIPT IS FOR SETTING UP LOCAL VAGRANT BOXES. 
#IT IS NOT SECURE ENOUGH FOR PRODUCTION.

#set some variables

#site URL - THIS MUST MATCH WHAT IS IN THE VAGRANTFILE
URL='dev.example.com'

#create MySQL DB and User
#assumes mysql_secure_install hasn't been run yet
DBNAME='example_database'
USER='example_user'
PASSWORD='password1234'

#prep for php7.1 install
apt-get install -y python-software-properties
add-apt-repository ppa:ondrej/php


#Update
apt-get -y update

# install stuff
apt-get install -y nginx
apt-get install -y mariadb-server
apt-get install -y php-fpm php-mysql php-cli
apt-get install -y curl git


#create conf file for website
cat <<EOF >/etc/nginx/sites-available/$URL
server {
        listen 80;
        listen [::]:80;

        root /var/www/$URL/public;
        index index.php index.html index.htm index.nginx-debian.html;

        server_name $URL;

        location / {
                try_files \$uri \$uri/ =404;
        }
        
        location ~ \.php$ {
                include snippets/fastcgi-php.conf;
                fastcgi_pass unix:/run/php/php7.0-fpm.sock;
        }

        location ~ /\.ht {
                deny all;
        }
        
        sendfile off;
}
EOF

#symlink the files
ln -s /etc/nginx/sites-available/$URL /etc/nginx/sites-enabled/

#restart nginx
service nginx restart

#install composer
#Usually composer is installed on host computer when using Vagrant
#cd /tmp
#curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#create user and DB if needed
mysql -uroot -e "CREATE DATABASE $DBNAME;"
mysql -uroot -e "CREATE USER '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON $DBNAME.* TO '$USER'@'localhost';"



