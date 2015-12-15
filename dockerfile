FROM php:5.6-apache

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# Install PHP Ext
RUN apt-get update && apt-get install -y \
        git \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        zlib1g-dev \
        libicu-dev \
        libxslt1-dev \
        g++ \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install xsl \
    && docker-php-ext-install zip \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mbstring

COPY ./data /var/www/html