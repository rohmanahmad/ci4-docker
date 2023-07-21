FROM php:8.2.9RC1-apache

LABEL maintainer="Rohman Ahmad <rohmanmail@gmail.com>"

# SET TIMEZONE
ARG TZ="Asia/Jakarta"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install --fix-missing curl
RUN apt-get -y install --fix-missing wget
RUN apt-get -y install --fix-missing software-properties-common
RUN apt-get -y install --fix-missing zip
RUN apt-get -y install --fix-missing unzip
RUN apt-get -y install --fix-missing libmagickwand-dev
RUN apt remove -y gdal-bin gdal-data libgdal20 && \
    apt -y autoremove && \
    apt update && apt -y upgrade && \
    apt install -y libpng-dev libgdal-dev

RUN pecl install imagick && docker-php-ext-enable imagick
RUN apt-get update && apt-get install -y libzip-dev zip && docker-php-ext-install zip
RUN docker-php-ext-install pdo pdo_mysql mysqli

USER ROOT
WORKDIR /var/www/html/app

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND