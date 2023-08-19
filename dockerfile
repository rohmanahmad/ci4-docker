# base for ci4

FROM php:8.2.9RC1-apache

LABEL maintainer="Rohman Ahmad <rohmanmail@gmail.com>"

COPY ./src/apache/httpd.conf /etc/apache2/conf-available/docker-php.conf
COPY ./src/apache/httpd-vhost.conf /etc/apache2/site-available/000-default.conf
COPY ./src/composer /usr/local/bin/composer

# SET TIMEZONE
ARG TZ="Asia/Jakarta"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get -y upgrade

RUN apt remove -y gdal-bin gdal-data libgdal20
RUN apt -y autoremove

RUN apt-get -y install --fix-missing software-properties-common
RUN apt-get -y install --fix-missing curl
RUN apt-get -y install --fix-missing wget
RUN apt-get -y install --fix-missing zip
RUN apt-get -y install --fix-missing libzip-dev
RUN apt-get -y install --fix-missing unzip
RUN apt-get -y install --fix-missing libmagickwand-dev
RUN apt-get -y install --fix-missing libpng-dev
RUN apt-get -y install --fix-missing libgdal-dev

RUN pecl install imagick && docker-php-ext-enable imagick
RUN docker-php-ext-install zip
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo

EXPOSE 80 445