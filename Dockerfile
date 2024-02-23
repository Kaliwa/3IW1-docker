FROM php:8.2-rc-fpm

RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    nodejs \
    npm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN mkdir -p /var/www/html/storage/logs
RUN touch /var/www/html/storage/logs/laravel.log
RUN chmod -R 777 /var/www/html/storage/logs/laravel.log

RUN apt-get update
RUN apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

RUN apt-get install -y default-mysql-client
RUN docker-php-ext-install pdo pdo_mysql

RUN echo "extension=pdo_mysql.so" >> /usr/local/etc/php/php.ini-production
RUN php -c /usr/local/etc/php/php.ini-production