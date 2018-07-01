FROM alpine
MAINTAINER Pablo Viojo <pviojo@grouponlatam.com>

RUN apk update
# Install Nginx
RUN apk add nginx

# Nginx configuration
ADD ./config/default /etc/nginx/sites-enabled/
ADD ./config/nginx.conf /etc/nginx/

#Install PHP7
RUN apk add php7 php7-fpm php7-gd php7-mysqli php7-zlib php7-curl php7-intl php7-openssl php7-pdo_mysql php7-pcntl php7-common php7-xsl php7-imagick php7-mysqlnd php7-enchant php7-pspell php7-redis php7-snmp php7-doc php7-mbstring php7-session php7-gd  php7-gettext  php7-json  php7-xml  php7-iconv  php7-curl  php7-phar  php7-pdo_pgsql  php7-pgsql  php7-zip  php7-mcrypt  php7-memcached php7-soap  php7-apcu php7-zlib  php7-pdo  php7-mysqli 

#PHP7 Configuration

COPY ./config/www.conf /etc/php7/php-fpm.d/www.conf
# Install Supervisor
RUN apk add supervisor

# Supervisor configuration
COPY ./config/supervisord.conf /etc
COPY ./config/supervisor-lemp.conf /etc/supervisor/conf.d/

RUN mkdir -p /var/log/supervisor/

#Mount Source code
COPY ./src /app

EXPOSE 80

WORKDIR /app

# Install Nginx
RUN apk add bash

CMD ["supervisord"]
